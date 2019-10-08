//
//  SwitchViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/2/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        if(status == true){
            rootVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
        }else {
            rootVC = UIStoryboard(name: "LoginController", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
        }
        self.navigationController?.pushViewController(rootVC!, animated: false)
    }
}
