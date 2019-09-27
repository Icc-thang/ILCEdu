//
//  ViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class  ViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBLoginButton(permissions: [ .publicProfile, .email])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("log out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let accessToken = AccessToken.current {
            // User is already logged in with facebook
            
//            let storyboard = UIStoryboard(name: "TabbarController", bundle: Bundle.main)
//            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarController") as! TabbarViewController
//            self.present(tabbarVC, animated: true, completion: nil)

            print("User is already logged in\(accessToken)")
        }
    }
}
