//
//  ProfileController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/24/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController , DelegateProfile {
    func getUserData() {
        tableView.reloadData()
    }
    
    var presenterProfile = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterProfile.delegate = self
        presenterProfile.requestProfile()
        registerNib()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func registerNib(){
        tableView.register(UINib(nibName: profileCell, bundle: nil), forCellReuseIdentifier: profileCell)
        //        tableView.register(UINib(nibName: processCell, bundle: nil), forCellReuseIdentifier: processCell)
        //        tableView.register(UINib(nibName: noteCell, bundle: nil), forCellReuseIdentifier: noteCell)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell) as! ProfileCell
        cell.setDataProfile(name: presenterProfile.profileModel?.name ?? "User name",
                            address:presenterProfile.profileModel?.address ?? "User address",
                            gender: presenterProfile.profileModel?.gender ?? "User gender",
                            dateOfBirth: presenterProfile.profileModel?.birthday ?? "User birthday",
                            phone: presenterProfile.profileModel?.phone ?? "User phone")
        cell.isUserInteractionEnabled = false
        return cell
        //        }
        
        //        if indexPath.row == 1{
        //            let cell = tableView.dequeueReusableCell(withIdentifier: processCell) as! ProcessCell
        //            return cell
        //        }
        //
        //        let cell = tableView.dequeueReusableCell(withIdentifier: noteCell) as! NoteCell
        //        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if indexPath.row == 0{
        return tableView.frame.width + 50
        //        }
        //        if indexPath.row == 1{
        //            return tableView.frame.width
        //        }
        //        return 85
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

