//
//  CardCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/25.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var japanLabel: UILabel!
    
    @IBOutlet weak var kanjiLabel: UILabel!
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    func setDataForCardCell(imageUrl:String?, japanese:String?, kanji:String?, example:String?) {
        
        frontImageView.sd_setImage(with: URL(string: baseUrlMedia + (imageUrl ?? "")))

        frontImageView.CardView()
    
        japanLabel.text = japanese ?? ""
        
        kanjiLabel.text = kanji ?? ""
        
        exampleLabel.text = example ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        japanLabel.textColor = UIColor.colorGreen
    }
    
    func flip()  {
        UIView.transition(from: frontImageView, to: view, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
    
    func flipBack(){
        UIView.transition(from: view, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }

}
