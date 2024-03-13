import Foundation
import SDWebImage

enum ImageCachePolicy {
    case none
    case disk
    case memory
    case memoryAndDisk
    
    func toSDCacheType() -> SDImageCacheType {
        switch self {
        case .none:
            return .none
        case .disk:
            return .disk
        case .memory:
            return .memory
        case .memoryAndDisk:
            return .all
        }
    }
}
