import Foundation
import UIKit


protocol ColorProtocol {
    var primary1: UIColor { get }
}

struct ThemeManager {
    static var colorShared: ColorProtocol = DarkColorTheme()
}


