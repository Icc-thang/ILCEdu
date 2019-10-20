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
    @IBOutlet weak var lessonName: UILabel!
    
    @IBOutlet weak var lessonImageView: UIImageView!
    
    @IBOutlet weak var lessonNumberVocab: UILabel!
    
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var progress: LinearProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20.0
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bgView.layer.shadowRadius = 8.0
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.cornerRadius = 20.0
        
        lessonNumberVocab.textColor = UIColor.colorGreen
        progress.trackColor = UIColor.colorGreen
    }
    
    func parseDataLessonCell(imgURL: String?, name: String?, title: String?, numberOfVocab: Int?) {
        lessonImageView.sd_setImage(with: URL(string: baseUrlMedia + (imgURL ?? "")))
        lessonName.text = name ?? ""
        lessonTitle.text = title ?? ""
        lessonNumberVocab.text = "\(numberOfVocab ?? 0)%"
    }
}
