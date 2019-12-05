//
//  PracticeCellA.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/13/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import CircleProgressView

class PracticeCell: UICollectionViewCell {

    @IBOutlet weak var practiceLevel: CircleProgressView!
    @IBOutlet weak var practiceLevelPercent: CircleProgressView!
    @IBOutlet weak var practicePercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        practiceLevel.trackFillColor = .colorGreen
        practiceLevel.centerImage = UIImage(named: "practice_img")
        practiceLevel.trackBackgroundColor = .colorGray
        practiceLevelPercent.centerFillColor = .colorGreen
        practiceLevelPercent.trackBackgroundColor = .white
        practicePercent.textColor = .colorYellow
    }

}
