//
//  MeaningVocabCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MeaningVocabCell: UITableViewCell {
    
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var meaningButton: UIButton!
    var isOpen:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        meaningButton.rx.tap.bind{ _ in
            if self.isOpen == false{
                self.meaningLabel.isHidden = false
                self.isOpen = true
            }else if self.isOpen == true{
                self.meaningLabel.isHidden = true
                self.isOpen = false
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isOpen = false
        self.meaningLabel.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
