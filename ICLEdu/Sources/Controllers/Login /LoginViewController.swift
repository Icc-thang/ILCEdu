//
//  LoginViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginFacebookButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginFacebookButton.BorderButton()
        loginButton.LoginButton()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginFB(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [ .publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(let granted, let declined, let token):
                print("token is : \(token)")
                let param = ["fields": "email, name, picture.type(large)"]
                GraphRequest(graphPath: "me", parameters: param).start { (connection, result, error) in
                    if let result = result {
                        let dict = JSON(result)
                        let fb_id = dict["id"].stringValue
                        // check fb_id với id user trong database. Trùng thì đăng nhập
                        print(fb_id)
                    }
                }
            case .cancelled:
                print("Cancelled")
                break
            case .failed(let err):
                print("login failed, error:\(err)")
                break
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        //set key for login
        UserDefaults.standard.set(1, forKey: "status")
        
        //push to lesson view controller
        let storyboard = UIStoryboard(name: "LessonController", bundle: Bundle.main)
        let lessonVC = storyboard.instantiateViewController(withIdentifier: "LessonController") as! LessonViewController
        if let navigator = navigationController {
            navigator.pushViewController(lessonVC, animated: true)
        }
    }
}
