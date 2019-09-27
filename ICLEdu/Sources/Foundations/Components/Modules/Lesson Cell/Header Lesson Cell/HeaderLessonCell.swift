//
//  HeaderLessonCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/23.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class HeaderLessonCell: UICollectionViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func parseDataLessonCell(img: String?) {
        headerImageView.sd_setImage(with: URL(string: img ?? "Không có dữ liệu cho header"))
    }
    
}
