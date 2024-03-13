import Foundation
import UIKit
import SDWebImage

class BRemoteImage: UIView {
    static let contextSourceKey = SDWebImageContextOption(rawValue: "source")
    static let screenScaleKey = SDWebImageContextOption(rawValue: "screenScale")
    
    let sdImageView = SDAnimatedImageView(frame: .zero)
    let imageManager = SDWebImageManager(cache: SDImageCache.shared, loader: SDImageLoadersManager.shared)
    
    var loadingOptions: SDWebImageOptions = [.retryFailed, .handleCookies]
    
    var source: String?
    
    var thumbhash: String?
//    = "3PcNNYSFeXh/k0oGLQaSVsN0BVhn2oq2Z5SQUQcZ"
    
    var pendingOperation: SDWebImageCombinedOperation?
    
    var blurRadius: CGFloat = 0.0
    
    var contentFit: ContentFit = .cover
    
    var cachePolicy: ImageCachePolicy = .disk
    
    var imageTintColor: UIColor?
    
    var placeholderImage: UIImage?
    
    
    
    var isViewEmpty: Bool {
        return sdImageView.image == nil
    }
    
    var placeholder: URL? {
        if thumbhash != nil {
            if let url = URL(string: "thumbhash://\(thumbhash)") {
                return url
            } else {
                return nil
            }
        }
        return nil
    }
    
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
        } else if !bounds.isEmpty {
            reload()
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
    
    func reload() {
        loadPlaceholderIfNecessary()
    }
    
    func loadPlaceholderIfNecessary() {
        guard (placeholder != nil), isViewEmpty else {
            return
        }
        var context: [SDWebImageContextOption: Any] = [:]
        context[.imageScaleFactor] = 1.0
        context[.queryCacheType] = SDImageCacheType.disk.rawValue
        context[.storeCacheType] = SDImageCacheType.disk.rawValue
        
        context[BRemoteImage.contextSourceKey] = placeholder
        
        
        imageManager.loadImage(with: placeholder, context: context, progress: nil) { [weak self] placeholder, _, _, _, finished, _ in
            guard let self = self, let placeholder = placeholder, finished else {
                return
            }
            self.placeholderImage = placeholder
            self.displayPlaceholderIfNecessary()
        }
    }
    
    private func displayPlaceholderIfNecessary() {
        guard isViewEmpty , let placeholder = placeholderImage else {
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
    
    static func registerLoaders() {
        //      SDImageLoadersManager.shared.addLoader(BlurhashLoader())\
        SDImageLoadersManager.shared.addLoader(ThumbhashLoader())
        //      SDImageLoadersManager.shared.addLoader(PhotoLibraryAssetLoader())
    }
}
