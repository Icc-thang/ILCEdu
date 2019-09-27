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
    
    
    func setDataForCardCell(imageUrl:String?, japanese:String?) {
        frontImageView.sd_setImage(with: URL(string: imageUrl ?? "Không có đường dẫn cho card"))

        frontImageView.CardView()
        
        japanLabel.text = japanese ?? "Không có dữ liệu tiếng Nhật 🙇‍♂️"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func flip()  {
        UIView.transition(from: frontImageView, to: japanLabel, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
    
    func flipBack(){
        UIView.transition(from: japanLabel, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
}
