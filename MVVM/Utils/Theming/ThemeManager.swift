import Foundation
import UIKit


protocol ColorProtocol {
    var primary: UIColor { get }
    var primaryFocus: UIColor { get }
    var primaryContent: UIColor { get }
    
    var secondary: UIColor { get }
    var secondaryFocus: UIColor { get }
    var secondaryContent: UIColor { get }
}

protocol FontProtocol {
    var heading1: UIFont { get }
    var heading2: UIFont { get }
    var heading3: UIFont { get }
    var heading4: UIFont { get }
    
    var title1Regular: UIFont { get }
    var title1Bold: UIFont { get }
    var title2Regular: UIFont { get }
    var title2Bold: UIFont { get }
}

struct ThemeManager {
    static var colorShared: ColorProtocol = DarkColorTheme()
    static var fontShared: FontProtocol = DefaultFont()
}


