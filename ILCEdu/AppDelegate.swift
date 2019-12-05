//
//  AppDelegate.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        checkLogin()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let urlScheme = url.scheme else { return false }
        if urlScheme.hasPrefix("fb") {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return true
    }
    
    func checkLogin() {
        if UserDefaults.standard.string(forKey: "authorization") != "" || UserDefaults.standard.string(forKey: "authorization") != nil {
            let rootVC = UIStoryboard(name: tabbarController, bundle: nil).instantiateViewController(withIdentifier: tabbarController) as! BubbleTabBarController
            let navVC = UINavigationController.init(rootViewController: rootVC)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
        if UserDefaults.standard.string(forKey: "authorization") == nil{
            let rootVC = UIStoryboard(name: loginController, bundle: nil).instantiateViewController(withIdentifier: loginController) as! LoginViewController
            let navVC = UINavigationController.init(rootViewController: rootVC)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
    }
}

