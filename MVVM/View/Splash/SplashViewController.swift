import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            let vc = LoginViewController()
            self.resetControllers([vc])
        })
    }
}
