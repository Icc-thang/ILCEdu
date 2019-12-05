//
//  ProfileCell.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/24/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    fileprivate var address:String?
    fileprivate var gender:String?
    fileprivate var dateOfBirth:String?
    fileprivate var phone:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        pictureImageView.CardImage()
        pictureImageView.sd_setImage(with: URL(string: avatar ?? avatarBase))
    }
    
    func setDataProfile(name:String?, address: String?, gender:String?, dateOfBirth:String?, phone:String?) {
        nameLabel.text = name ?? ""
        addressLabel.text = address ?? ""
        genderLabel.text = gender ?? ""
        birthdayLabel.text = dateOfBirth ?? ""
        phoneNumberLabel.text = phone ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
