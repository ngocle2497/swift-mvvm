import Foundation
import Combine

enum Language: String {
    case english = "English"
    case vietnam = "VietNam"
}

class AppSettings: ObservableObject {
    @Published var language: Language = .english
}
