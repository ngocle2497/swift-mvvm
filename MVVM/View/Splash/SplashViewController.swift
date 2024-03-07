//
//  SplashViewController.swift
//  MVVM
//
//  Created by Ngoc H. Le on 07/03/2024.
//

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
