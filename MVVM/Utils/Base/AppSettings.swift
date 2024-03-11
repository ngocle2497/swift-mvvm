import Foundation
import Combine

class AppSettings: ObservableObject {
    @Published var language = "English"
}

class UserSettings: ObservableObject {
    @Published var isAuthenticated = false
}
