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
    @IBOutlet weak var useNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var admissionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        logoutButton.BorderButton()
        logoutButton.setTitleColor(UIColor.deepBlue, for: .normal)
        
        pictureImageView.sd_setImage(with: URL(string: "https://i.pinimg.com/originals/b3/84/98/b38498a5830bd61ccef1b54d35a7de22.jpg" ))
        pictureImageView.CircleImage()
        
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        
    }
    
}
