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
    
    let presenterLogin = PresenterLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginFacebookButton.FacebookButton()
        // Do any additional setup after loading the view.
        presenterLogin.delegateLogin = self
        
    }
    
    @IBAction func loginFB(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [ .publicProfile], viewController: self) { (result) in
            switch result {
            case .success(_, _, _):
                print("tokenFacebook : \(AccessToken.current?.tokenString ?? "")")
                self.presenterLogin.getDataForLogin(tokenFB: AccessToken.current?.tokenString ?? "")
                let param = ["fields": "email, name, picture.type(large)"]
                GraphRequest(graphPath: "me", parameters: param).start { (connection, result, error) in
                    if let result = result {
                        let dict = JSON(result)
                        let name = dict["name"].stringValue
                        let avatar = dict["picture"]["data"]["url"].stringValue
                        UserDefaults.standard.set(avatar, forKey: "avatar")
                        UserDefaults.standard.set(name, forKey: "name")
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
    func getDataLogin() {
        //log thông báo
//        if(token == nil || token == ""){
//            let registerVC = UIStoryboard(name: "RegisterController", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as! RegisterViewController
//            registerVC.getDataFB(avatar: self.presenterLogin.avatar ?? "",
//                                 name: self.presenterLogin.name ?? "",
//                                 memberID: self.presenterLogin.loginModel?.id ?? 0)
//            self.navigationController?.pushViewController(registerVC, animated: true)
            //set key for login
//        }else {
//            //set key for login
//            UserDefaults.standard.set(self.presenterLogin.loginModel?.access_token ?? "", forKey: "authorization")
//
//            let tabbarVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
//            self.navigationController?.pushViewController(tabbarVC, animated: true)
//        }
        
        UserDefaults.standard.set(self.presenterLogin.loginModel?.access_token ?? "", forKey: "authorization")
        
        let tabbarVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}
