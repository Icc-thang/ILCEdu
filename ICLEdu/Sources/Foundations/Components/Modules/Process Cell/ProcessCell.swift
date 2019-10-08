//
//  ProcessCell.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/8/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import PieCharts

class ProcessCell: UITableViewCell {
    
    
    @IBOutlet weak var processView: PieChart!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        processView.models = [
            PieSliceModel(value: 2, color: UIColor.yellow),
            PieSliceModel(value: 3, color: UIColor.blue),
            PieSliceModel(value: 1, color: UIColor.green)
        ]
        processView.layers = [PieLineTextLayer()]
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
