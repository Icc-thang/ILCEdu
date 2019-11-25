//
//  LessonCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/23.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

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
//        loadingData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        lessonImageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
//        Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(removeLoader), userInfo: nil, repeats: false)
    }
    
//    func loadingData(){
//        lessonImageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
//        Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(removeLoader), userInfo: nil, repeats: false)
//    }
    
//    @objc func removeLoader()
//    {
//        lessonImageView.hideSkeleton(transition: .crossDissolve(0.25))
//    }
    func backgroundSetup(){
        bgView.layer.cornerRadius = 20.0
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        bgView.layer.shadowRadius = 8.0
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.cornerRadius = 20.0
    }
    
    func progressSetup(){
        progressLabel.textColor = UIColor.colorGreen
        progress.trackColor = UIColor.colorGreen
        progress.minimumValue = Float(0)
    }
    
    func parseDataLessonCell(imgURL: String?, name: String?, title: String?, lesson_finish:Int?, numberOfVocab: Int?, positionVocab: Int?) {
        //
        lessonImageView.sd_setImage(with: URL(string: baseUrlMedia + (imgURL ?? "https://imgur.com/ftmP9wk")))
        //
        lessonName.text = name ?? ""
        lessonTitle.text = title ?? ""
        
        progress.maximumValue = Float(100)
        
        if lesson_finish ?? 0 == 0{
            var percentPerVocab:Double?
            // tính phần trăm cho tổng số từ
            if numberOfVocab ?? 0 == 0 {
                percentPerVocab = 0
            }else {
                percentPerVocab = 100/Double(numberOfVocab ?? 0)
            }
            //tính phần trăm số từ hiện tại
            let totalPercent:Double = Double((positionVocab ?? 0)) * Double((percentPerVocab ?? 0))
            progressLabel.text = "\(Int(totalPercent.rounded()))%"
            progress.setProgress(Float(totalPercent), animated: false)
        }else{
            progressLabel.text = "100%"
            progress.setProgress(Float(100), animated: false)
        }
    }
}
