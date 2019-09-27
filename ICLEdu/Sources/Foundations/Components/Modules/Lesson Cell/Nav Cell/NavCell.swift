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

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.CircleImage()
    }
    func parseDataForNav(userName:String?, userImageUrl:String?){
        userNameLabel.text = userName ?? "Không có dữ liệu tên người dùng"
        userImageView?.sd_setImage(with: URL(string:"\(userImageUrl ?? "Không có dữ liệu cho ảnh đại diện")"))
        
    }
}
