import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        Environment.shared.register(AppSettings())
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ThemeManager.colorShared = DarkColorTheme()
        window = UIWindow.init();
   
        
        let navigation = UINavigationController(rootViewController: SplashViewController())
//        navigation.isNavigationBarHidden = true
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

