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
    
    @IBOutlet weak var loginFacebookButton: UIButton!
    
    @IBOutlet weak var facebookView: UIView!
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
    
    let presenterLogin = PresenterLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterLogin.delegateLogin = self
        facebookView.FacebookButton()
    }
    
    @IBAction func loginFB(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [ .publicProfile], viewController: self) { (result) in
            switch result {
            case .success(_):
                let param = ["fields": "name, picture.type(large),email"]
                GraphRequest(graphPath: "me", parameters: param).start { (connection, result, error) in
                    if let result = result {
                        self.showSpinner(onView: self.view)
                        let dict = JSON(result)
                        let name = dict["name"].stringValue
                        let avatar = dict["picture"]["data"]["url"].stringValue
                        UserDefaults.standard.set(avatar, forKey: "avatar")
                        UserDefaults.standard.set(name, forKey: "name")
                        self.presenterLogin.getDataForLogin(tokenFB: "\(dict)")
                    }
                }
            case .cancelled:
                print("Cancelled")
                break
            case .failed(let err):
                print("Đăng nhập Facebook không thành công, nội dung lỗi: \(err)")
                break
            }
        }
    }
}
extension LoginViewController: LoginDelegate {
    func ifLoginError() {
        // create the alert
        self.removeSpinner()
        let alert = UIAlertController(title: "Something wrong!", message: "Unable to connect to the server", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { action in
            
            if AccessToken.current?.tokenString != nil{
                self.showSpinner(onView: self.view)
                self.presenterLogin.getDataForLogin(tokenFB: AccessToken.current?.tokenString ?? "")
            }else {
                print("Đăng nhập Facebook lỗi")
            }
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getDataLogin() {
        UserDefaults.standard.set(presenterLogin.loginModel?.id ?? 0, forKey: "idMember")
        if self.presenterLogin.loginModel?.access_token == "" {
            self.removeSpinner()
            let registerVC = UIStoryboard(name: registerController, bundle: nil).instantiateViewController(withIdentifier: registerController) as! RegisterViewController
            self.navigationController?.pushViewController(registerVC, animated: true)
            
        }else{
            self.removeSpinner()
        UserDefaults.standard.set(self.presenterLogin.loginModel?.access_token ?? "", forKey: "authorization")
            let tabbarVC = UIStoryboard(name: tabbarController, bundle: nil).instantiateViewController(withIdentifier: tabbarController) as! BubbleTabBarController
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}
