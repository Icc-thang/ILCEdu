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
    func getDataLogin() {
        UserDefaults.standard.set(presenterLogin.loginModel?.id ?? 0, forKey: "idMember")
        if self.presenterLogin.loginModel?.access_token == "" {
            let registerVC = UIStoryboard(name: "RegisterController", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as! RegisterViewController
            self.navigationController?.pushViewController(registerVC, animated: true)
            
        }else{
            UserDefaults.standard.set(self.presenterLogin.loginModel?.access_token ?? "", forKey: "authorization")
            let tabbarVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}
