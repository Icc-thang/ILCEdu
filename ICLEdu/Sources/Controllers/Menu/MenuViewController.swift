//
//  MenuViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/17/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import FacebookLogin

fileprivate let menuCell = "MenuCell"
class MenuViewController: UITableViewController {
    
    fileprivate let image = [avatar, "ic_logout"]
    fileprivate let menuTitle = ["個人ページ", "ログアウト"]
    
//    let presenterMenu = PresenterMenu()
    
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.presenterMenu.getDataForProfile()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.presenterMenu.delegateMenu = self as? DelegateMenu
        
        let menuNib = UINib(nibName: menuCell, bundle: nil)
        tableView.register(menuNib, forCellReuseIdentifier: menuCell)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "MENU"
        label.textColor = UIColor.black
        view.addSubview(label)
        
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as! MenuCell
            cell.setDataForMenu(menuSource: image[indexPath.row], title: menuTitle[indexPath.row])
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
            profileVC.presenterProfile = PresenterProfile()
            profileVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        if indexPath.row == 1 {
            UserDefaults.standard.removeObject(forKey: "authorization")
            
            let loginManager = LoginManager()
            loginManager.logOut()
            
            let rootVC = UIStoryboard(name: "LoginController", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
            let navVC = UINavigationController.init(rootViewController: rootVC)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
        
    }
}
