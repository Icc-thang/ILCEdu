//
//  ProfileViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage


class ProfileViewController: UIViewController, DelegateProfile {
  
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var admissionLabel: UILabel!
    
    let presenterProfile = PresenterProfile()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.presenterProfile.delegateProfile = self
        self.presenterProfile.getDataForProfile()
        setupUI()
        
    }
    func setupUI(){
        pictureImageView.CircleImage()
        self.navigationItem.title = name
        pictureImageView.sd_setImage(with: URL(string: avatar ?? ""))
    }
    func getDataProfile() {
          addressLabel.text = self.presenterProfile.profileModel?.address
          genderLabel.text = self.presenterProfile.profileModel?.gender
          birthdayLabel.text = self.presenterProfile.profileModel?.birthday
          phoneNumberLabel.text = self.presenterProfile.profileModel?.phone
      }
}
