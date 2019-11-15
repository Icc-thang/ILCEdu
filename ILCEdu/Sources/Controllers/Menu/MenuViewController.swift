//
//  MenuViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/17/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookLogin


class MenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        registerMenuCell()
        
    }
    
    func navigationSetup(){
        let view = NaviView()
        view.setNavigationView(classLabel: tabMenu,
                               userAvatar: UserDefaults.standard.string(forKey: "avatar") ?? avatarBase)
        navigationItem.titleView = view
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func registerMenuCell(){
        tableView.register(UINib(nibName: menuCell, bundle: nil), forCellReuseIdentifier: menuCell)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleMenu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as! MenuCell
            cell.setDataForMenu(menuSource: imageMenu[indexPath.row], title: titleMenu[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as! MenuCell
        cell.setDataForMenu(menuSource: imageMenu[indexPath.row]!, title: titleMenu[indexPath.row])
        cell.setImageWithAccess(menuSource: imageMenu[indexPath.row]!, title: titleMenu[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let profileVC = UIStoryboard(name: profileController, bundle: nil).instantiateViewController(withIdentifier: profileController) as! ProfileViewController
            profileVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        if indexPath.row == 1 {
            UserDefaults.standard.removeObject(forKey: "authorization")
            
            let loginManager = LoginManager()
            loginManager.logOut()
            
            let rootVC = UIStoryboard(name: loginController, bundle: nil).instantiateViewController(withIdentifier: loginController) as! LoginViewController
            let navVC = UINavigationController.init(rootViewController: rootVC)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
        
    }
}
