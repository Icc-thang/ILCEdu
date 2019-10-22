//
//  MenuViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/17/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookLogin

let menuCell = "MenuCell"
class MenuViewController: UITableViewController {
    let image = [avatar, "ic_chart", "ic_logout"]
    let menuTitle = ["個人ページ", "分析", "ログアウト"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tokenHeader)
        let menuNib = UINib(nibName: menuCell, bundle: nil)
        tableView.register(menuNib, forCellReuseIdentifier: menuCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as! MenuCell
            cell.setDataForMenu(menuSource: image[indexPath.row]!, title: menuTitle[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as! MenuCell
        cell.setDataForMenu(menuSource: image[indexPath.row]!, title: menuTitle[indexPath.row])
        cell.setImageWithAccess(menuSource: image[indexPath.row]!, title: menuTitle[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let profileVC = UIStoryboard(name: "ProfileController", bundle: nil).instantiateViewController(withIdentifier: "ProfileController") as! ProfileViewController
            profileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        if indexPath.row == 1 {
            let processVC = UIStoryboard(name: "ProcessController", bundle: nil).instantiateViewController(withIdentifier: "ProcessController") as! ProcessViewController
            processVC.setTitle(title: menuTitle[indexPath.row])
            processVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(processVC, animated: true)
        }
        if indexPath.row == 2 {
            UserDefaults.standard.removeObject(forKey: "authorization")
            
            let loginManager = LoginManager()
            loginManager.logOut()
            
            let alertController = UIAlertController(
                title: "ログアウト",
                message: "終わります。",
                preferredStyle: .alert
            )
            present(alertController, animated: true, completion: nil)
            
            let rootVC = UIStoryboard(name: "LoginController", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
            let navVC = UINavigationController.init(rootViewController: rootVC)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
        
    }
}
