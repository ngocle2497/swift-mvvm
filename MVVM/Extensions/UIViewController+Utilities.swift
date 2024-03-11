import Foundation
import UIKit

extension UIViewController {
    
    func pushController(_ vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func resetControllers(_ vcs: [UIViewController]) {
        self.navigationController?.setViewControllers(vcs, animated: true)
    }
    
}
