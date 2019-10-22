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
    
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var progress: LinearProgressView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20.0
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bgView.layer.shadowRadius = 8.0
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.cornerRadius = 20.0
        
        progressLabel.textColor = UIColor.colorGreen
        progress.trackColor = UIColor.colorGreen
        progress.minimumValue = Float(0)
    }
    
    func parseDataLessonCell(imgURL: String?, name: String?, title: String?, lesson_finish:Int?, numberOfVocab: Int?, positionVocab: Int?) {
        lessonImageView.sd_setImage(with: URL(string: baseUrlMedia + (imgURL ?? "")))
        lessonName.text = name ?? ""
        lessonTitle.text = title ?? ""
        
        progress.maximumValue = Float(numberOfVocab ?? 0)
        
        progress.setProgress(Float(positionVocab ?? 0), animated: true)
        
        if lesson_finish ?? 0 == 0{
            // tính phần trăm cho tổng số từ
            let percent = 100/(numberOfVocab ?? 0)
            //tính phần trăm số từ hiện tại
            let ssv = (positionVocab ?? 0) * percent
            progressLabel.text = "\(ssv)%"
        }else{
            progressLabel.text = "100%"
        }
    }
}
