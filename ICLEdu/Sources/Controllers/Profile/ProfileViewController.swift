//
//  ProfileController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/24/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    let presenterProfile = PresenterProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenterProfile.delegateProfile = self as? DelegateProfile
        
        
        tableView.register(UINib(nibName: profileCell, bundle: nil), forCellReuseIdentifier: profileCell)
        //        tableView.register(UINib(nibName: processCell, bundle: nil), forCellReuseIdentifier: processCell)
        //        tableView.register(UINib(nibName: noteCell, bundle: nil), forCellReuseIdentifier: noteCell)
    }
    
    func getDataProfile(profileData: ProfileModel?) {
        presenterProfile.getProfileModel(profileModel : profileData)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell) as! ProfileCell
        cell.setDataProfile(name: presenterProfile.profileModel?.name,
                            address: presenterProfile.profileModel?.address,
                            gender: presenterProfile.profileModel?.gender,
                            dateOfBirth: presenterProfile.profileModel?.birthday,
                            phone: presenterProfile.profileModel?.phone)
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
        return tableView.frame.width + 15
        //        }
        //        if indexPath.row == 1{
        //            return tableView.frame.width
        //        }
        //        return 85
    }
}

