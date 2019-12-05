//
//  AnswerCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/26/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var choseStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.AnswerView()
        choseStatus.AnswerChosed()
    }
    func checkChose(position : Int){
        if position == 2 {
            choseStatus.backgroundColor = .colorGreen
        }else if position == 3 {
            choseStatus.backgroundColor = .colorGreen
        }else if position == 4 {
            choseStatus.backgroundColor = .colorGreen
        }else if position == 5 {
            choseStatus.backgroundColor = .colorGreen
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
