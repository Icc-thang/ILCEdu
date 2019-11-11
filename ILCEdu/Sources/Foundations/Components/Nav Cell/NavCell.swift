//
//  NavCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/24.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class NavCell: UICollectionViewCell {

    @IBOutlet weak var navTimeLabel: UILabel!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var navUserImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        getDateTime()
    }
    
    func getDateTime(){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyy"
        let formattedDate = format.string(from: date)
        let dayNumber = Calendar.current.component(.weekday, from: date)
        if dayNumber == 2 {
            navTimeLabel.text = "月曜日, \(formattedDate)"
        }else if dayNumber == 3 {
            navTimeLabel.text = "火曜日, \(formattedDate)"
        }else if dayNumber == 4 {
            navTimeLabel.text = "水曜日, \(formattedDate)"
        }else if dayNumber == 5 {
            navTimeLabel.text = "木曜日, \(formattedDate)"
        }else if dayNumber == 6 {
            navTimeLabel.text = "金曜日, \(formattedDate)"
        }else if dayNumber == 7 {
            navTimeLabel.text = "土曜日, \(formattedDate)"
        }else if dayNumber == 1 {
            navTimeLabel.text = "日曜日, \(formattedDate)"
        }
    }
    func parseDataForNav(screenKey:String?, userName:String?, userImageUrl:String?){
        navUserImageView?.sd_setImage(with: URL(string:"\(userImageUrl ?? avatarBase)"))
        if screenKey == tabLesson {
        navTitleLabel.text = "こんにちは, \(userName ?? "")"
        }else if screenKey == tabPractice {
        navTitleLabel.text = tabPractice
        }
       
    }
}
