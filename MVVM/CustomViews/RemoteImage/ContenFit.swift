import Foundation
import UIKit

enum ContentFit {
    case contain
    case cover
    case `fill`
    case `none`
    case scaleDown
    
    func toContentMode() -> UIView.ContentMode {
        switch self {
        case .contain:
            return .scaleAspectFit
        case .cover:
            return .scaleAspectFill
        case .fill:
            return .scaleToFill
        case .none, .scaleDown:
            return .center
        }
    }
    
}
