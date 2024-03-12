import Foundation
import Combine

enum Language: String {
    case english = "English"
    case vietnam = "VietNam"
}

enum ColorTheme: String {
    case dark = "dark"
    case light = "light"
}

enum FontSize: String {
    case `default` = "Default"
    case large = "Large"
}


class AppSettings: ObservableObject {
    @Published var language: Language = .english
    @Published private var _theme: ColorTheme = LocalStorage.shared.appTheme!
    @Published private var _fontSize: FontSize = LocalStorage.shared.appFont!

     init() {
        ThemeManager.updateFont(_fontSize)
        ThemeManager.updateTheme(_theme)
    }
    
    var theme: ColorTheme {
        get {
            return _theme
        }
        set {
            LocalStorage.shared.appTheme = newValue
            ThemeManager.updateTheme(newValue)
            _theme = newValue
        }
    }
    
    var fontSize: FontSize {
        get {
            return _fontSize
        }
        set {
            LocalStorage.shared.appFont = newValue
            ThemeManager.updateFont(newValue)
            _fontSize = newValue
        }
    }
}
