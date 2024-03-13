import Foundation
import SDWebImage

class ThumbhashLoader: NSObject, SDImageLoader {
    func canRequestImage(for url: URL?) -> Bool {
        return url?.scheme == "thumbhash"
        
    }
    
    func requestImage(with url: URL?, options: SDWebImageOptions = [], context: [SDWebImageContextOption : Any]?, progress progressBlock: SDImageLoaderProgressBlock?, completed completedBlock: SDImageLoaderCompletedBlock? = nil) -> SDWebImageOperation? {
        guard let url = url else {
            completedBlock?(nil, nil, NSError(domain: "ThumHas", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL provided to ThumbhashLoader is missing" ]), false)
            return nil
        }
        var thumbhash = (url.pathComponents[1]).replacingOccurrences(of: "\\", with: "/")
        let remainder = thumbhash.count % 4
        if remainder > 0 {
            thumbhash = thumbhash.padding(toLength: thumbhash.count + 4 - remainder, withPad: "=", startingAt: 0)
        }
        
        guard !thumbhash.isEmpty, let thumbhashData = Data(base64Encoded: thumbhash, options: .ignoreUnknownCharacters) else {
            completedBlock?(nil, nil, NSError(domain: "ThumHas", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL provided to ThumbhashLoader is invalid" ]), false)
            return nil
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let image = image(fromThumbhash: thumbhashData)
            DispatchQueue.main.async {
                completedBlock?(image, nil, nil, true)
            }
        }
        return nil
    }
    
    func shouldBlockFailedURL(with url: URL, error: Error) -> Bool {
        return true
    }
    
    
}
