//
//  AppDelegate.swift
//  MVVM
//
//  Created by Ngoc H. Le on 06/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init();
   
        
        let navigation = UINavigationController(rootViewController: SplashViewController())
        navigation.isNavigationBarHidden = true
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

