//
//  CardView.swift
//  AlamofireTest
//
//  Created by Ta Tuan Macbook on 3/22/19.
//  Copyright © 2019 HiUPTeam. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.7
    }
    
}
