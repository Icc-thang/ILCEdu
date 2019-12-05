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
        backgroundSetup()
        progressSetup()
    }
    
    func backgroundSetup(){
        bgView.layer.cornerRadius = 20.0
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bgView.layer.shadowRadius = 8.0
        bgView.layer.shadowOpacity = 0.7
    }
    
    func progressSetup(){
        progressLabel.textColor = UIColor.colorGreen
        progress.trackColor = UIColor.colorGreen
        progress.minimumValue = Float(0)
        progress.maximumValue = Float(100)
    }
    
    func parseDataLessonCell(imgURL: String?, name: String?, title: String?, totalPercent: Double) {
        DispatchQueue.main.async {
            self.lessonImageView.sd_setImage(with: URL(string: baseUrlMedia + (imgURL ?? "https://imgur.com/ftmP9wk")), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload], completed: nil)
            
            self.lessonName.text = name ?? ""
            self.lessonTitle.text = title ?? ""
            
            self.progressLabel.text = "\(Int(totalPercent.rounded()))%"
            self.progress.setProgress(Float(totalPercent), animated: false)
        }
    
    }
}
