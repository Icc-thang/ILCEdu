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
        
        let status = UserDefaults.standard.integer(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        if(status == 1){
            rootVC = UIStoryboard(name: "LessonController", bundle: nil).instantiateViewController(withIdentifier: "LessonController") as! LessonViewController
        }else if (status == 0){
            
            rootVC = UIStoryboard(name: "RegisterController", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as! RegisterViewController
        }else if (status == 2){
            rootVC = UIStoryboard(name: "LoginController", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
        }
        self.navigationController?.pushViewController(rootVC!, animated: false)
    }
}
