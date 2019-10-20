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

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.CircleImage()
        getDateTime()
    }
    
    func getDateTime(){
     
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyy"
        let formattedDate = format.string(from: date)
        let dayNumber = Calendar.current.component(.weekday, from: date)
        if dayNumber == 2 {
            timeLabel.text = "月曜日, \(formattedDate)"
        }else if dayNumber == 3 {
            timeLabel.text = "火曜日, \(formattedDate)"
        }else if dayNumber == 4 {
            timeLabel.text = "水曜日, \(formattedDate)"
        }else if dayNumber == 5 {
            timeLabel.text = "木曜日, \(formattedDate)"
        }else if dayNumber == 6 {
            timeLabel.text = "金曜日, \(formattedDate)"
        }else if dayNumber == 7 {
            timeLabel.text = "土曜日, \(formattedDate)"
        }else if dayNumber == 1 {
            timeLabel.text = "日曜日, \(formattedDate)"
        }
    }
    func parseDataForNav(userName:String?, userImageUrl:String?){
        userNameLabel.text = "こんにちは, \(userName ?? "")"
        userImageView?.sd_setImage(with: URL(string:"\(userImageUrl ?? "Không có dữ liệu cho ảnh đại diện")"))
        
    }
}
