import Foundation
import UIKit
import SDWebImage

class BRemoteImage: UIView {
    static let contextSourceKey = SDWebImageContextOption(rawValue: "source")
    
    private let sdImageView = SDAnimatedImageView(frame: .zero)
    private let imageManager = SDWebImageManager(cache: SDImageCache.shared, loader: SDImageLoadersManager.shared)
    private var loadingImage = false
    
    var loadingOptions: SDWebImageOptions = [.retryFailed, .handleCookies]
    
    var blurRadius: CGFloat = 0.0
    
    var contentFit: ContentFit = .cover
    
    var cachePolicy: ImageCachePolicy? = .disk
    
    var imageTintColor: UIColor?
    
    var transition: ImageTransition? = ImageTransition(duration: 2, effect: .crossDissolve)
    
    var source: String? {
        didSet {
            if oldValue != source {
                loadingImage = true
                reload()
            }
        }
    }
    
    var placeholderHash: PlaceholderHash? {
        didSet {
            if placeholderHash != nil, oldValue != placeholderHash {
                guard let url = placeholderHash?.url else {
                    return
                }
                needShowPlaceholder = true
                placeholder = url
                loadPlaceholderIfNecessary()
            }
        }
    }
    
    private var pendingOperation: SDWebImageCombinedOperation?
    
    private var needShowPlaceholder: Bool = false
    
    private var placeholderImage: UIImage?
    
    private  var isViewEmpty: Bool {
        return sdImageView.image == nil
    }
    
    private var placeholder: URL?
    
    public override var bounds: CGRect {
        didSet{
            if oldValue.size != bounds.size && window != nil {
                reload()
            }
        }
    }
    
    public override func didMoveToWindow() {
        if window == nil {
            cancelPendingOperation()
        } else {
            loadPlaceholderIfNecessary()
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(sdImageView)
        BRemoteImage.registerLoaders()
        clipsToBounds = true
        sdImageView.translatesAutoresizingMaskIntoConstraints = false
        sdImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sdImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sdImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sdImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        sdImageView.contentMode = contentFit.toContentMode()
        sdImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sdImageView.layer.masksToBounds = false
        sdImageView.layer.magnificationFilter = .trilinear
        sdImageView.layer.minificationFilter = .trilinear
        
    }
    
    private func reload() {
        displayPlaceholderIfNecessary()
        guard source != nil, let source = URL(string: source!) else {
            return
        }
        if sdImageView.image == nil {
            sdImageView.contentMode = contentFit.toContentMode()
        }
        
        // Cancel currently running load requests.
        cancelPendingOperation()
        
        var context: [SDWebImageContextOption: Any] = [:]
        context[.imageTransformer] = createTransformPipeline()
        
        context[.queryCacheType] = SDImageCacheType.none.rawValue
        context[.storeCacheType] = SDImageCacheType.none.rawValue
        if cachePolicy != nil {
            let sdCacheType = cachePolicy!.toSDCacheType().rawValue
            context[.originalQueryCacheType] = sdCacheType
            context[.originalStoreCacheType] = sdCacheType
        } else {
            context[.originalQueryCacheType] = SDImageCacheType.none.rawValue
            context[.originalStoreCacheType] = SDImageCacheType.none.rawValue
        }
        
        
        loadingImage = true
        pendingOperation = imageManager.loadImage(
            with: source,
            options: loadingOptions,
            context: context,
            progress: nil,
            completed: imageLoadCompleted(_:_:_:_:_:_:)
        )
    }
    
    
    private func imageLoadCompleted(
        _ image: UIImage?,
        _ data: Data?,
        _ error: Error?,
        _ cacheType: SDImageCacheType,
        _ finished: Bool,
        _ imageUrl: URL?
    ) {
        
        if error != nil {
            return
        }
        guard finished else {
            return
        }
        if let image = image {
            loadingImage = false
            renderImage(image)
        } else {
            displayPlaceholderIfNecessary()
        }
    }
    
    private func renderImage(_ image: UIImage?) {
        if let transition = transition, transition.duration > 0 {
            let options = transition.toAnimationOptions()
            let seconds = transition.duration
            
            UIView.transition(with: sdImageView, duration: seconds, options: options) { [weak self] in
                if let self = self {
                    self.setImage(image, contentFit: self.contentFit, isPlaceholder: false)
                }
            }
        } else {
            setImage(image, contentFit: contentFit, isPlaceholder: false)
        }
    }
    
    private func createCacheKeyFilter() -> SDWebImageCacheKeyFilter? {
        guard let placeholder = placeholder else {
            return nil
        }
        return SDWebImageCacheKeyFilter { _ in
            return placeholder.lastPathComponent
        }
    }
    
    private  func loadPlaceholderIfNecessary() {
        guard (placeholder != nil), needShowPlaceholder else {
            return
        }
        var context: [SDWebImageContextOption: Any] = [:]
        context[.imageScaleFactor] = 1.0
        context[.queryCacheType] = SDImageCacheType.none.rawValue
        context[.storeCacheType] = SDImageCacheType.none.rawValue
        context[.cacheKeyFilter] = createCacheKeyFilter()
        
        context[BRemoteImage.contextSourceKey] = placeholder
        
        imageManager.loadImage(with: placeholder, context: context, progress: nil) { [weak self] placeholder, _, _, _, finished, _ in
            guard let self = self, let placeholder = placeholder, finished else {
                return
            }
            self.placeholderImage = placeholder
            self.displayPlaceholderIfNecessary()
        }
    }
    
    private func createTransformPipeline() -> SDImagePipelineTransformer {
        let transformers: [SDImageTransformer] = [
            SDImageBlurTransformer(radius: blurRadius)
        ]
        return SDImagePipelineTransformer(transformers: transformers)
    }
    
    private func displayPlaceholderIfNecessary() {
        guard let placeholder = placeholderImage, loadingImage else {
            return
        }
        setImage(placeholder, contentFit: .cover, isPlaceholder: true)
    }
    
    private func setImage(_ image: UIImage?, contentFit: ContentFit, isPlaceholder: Bool) {
        sdImageView.contentMode = contentFit.toContentMode()
        
        if let imageTintColor, !isPlaceholder {
            sdImageView.tintColor = imageTintColor
            sdImageView.image = image?.withRenderingMode(.alwaysTemplate)
        } else {
            sdImageView.tintColor = nil
            sdImageView.image = image
        }
    }
    
    func cancelPendingOperation() {
        pendingOperation?.cancel()
        pendingOperation = nil
    }
    
    private static func registerLoaders() {
        SDImageLoadersManager.shared.addLoader(BlurhashLoader())
        SDImageLoadersManager.shared.addLoader(ThumbhashLoader())
        //      SDImageLoadersManager.shared.addLoader(PhotoLibraryAssetLoader())
    }
}

enum PlaceholderHash: Equatable {
    case blurhash(String)
    case thumbhash(String)
    
    var url: URL? {
        switch self {
        case .blurhash(let url):
            if let blurhashUrl = url
                .replacingOccurrences(of: "blurhash:/", with: "")
                .addingPercentEncoding(withAllowedCharacters: .alphanumerics){
                return URL(string: "blurhash:/\(blurhashUrl)")
            } else {
                return nil
            }
        case .thumbhash(let url):
            if let thumbhashUrl = url
                .replacingOccurrences(of: "thumbhash:/", with: "")
                .replacingOccurrences(of: "/", with: "\\")
                .addingPercentEncoding(withAllowedCharacters: .alphanumerics){
                return URL(string: "thumbhash:/\(thumbhashUrl)")
            } else {
                return nil
            }
        }
    }
}
