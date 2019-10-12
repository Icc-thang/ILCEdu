//
//  ProfileViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage
import FacebookLogin

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var admissionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI(){
        logoutButton.BorderButton()
        logoutButton.setTitleColor(UIColor.deepBlue, for: .normal)
        pictureImageView.CircleImage()
        self.navigationItem.title = profileData?.name ?? ""
        pictureImageView.sd_setImage(with: URL(string: profileData?.avatar ?? "" ))
        addressLabel.text = profileData?.address
        genderLabel.text = profileData?.gender
        birthdayLabel.text = profileData?.birthday
        phoneNumberLabel.text = "\(profileData?.phone ?? 0)"
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "authorization")
        
        //        let loginManager = LoginManager()
        //        loginManager.logOut()
        
        let alertController = UIAlertController(
            title: "Logout",
            message: "Logged out.",
            preferredStyle: .alert
        )
        present(alertController, animated: true, completion: nil)
    }
    
}
