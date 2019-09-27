//
//  LessonCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/23.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class LessonCell: UICollectionViewCell {
    @IBOutlet weak var lessonNum: UILabel!
    @IBOutlet weak var lessonImageView: UIImageView!
    @IBOutlet weak var lessonNameImageView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    func parseDataLessonCell(img: String?, name: String?, num: String?) {
        lessonImageView.sd_setImage(with: URL(string: img ?? "Không có dữ liệu cho card lesson"))
        lessonNameImageView.text = name
        lessonNum.text = num
    }
}
