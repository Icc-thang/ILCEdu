//
//  CircleImage.swift
//  AlamofireTest
//
//  Created by Ta Tuan Macbook on 3/20/19.
//  Copyright © 2019 HiUPTeam. All rights reserved.
//

import UIKit

extension UIImageView{
    func CircleImage()  {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
        
    }
    
    func BorderImage()  {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.gray.cgColor
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
    }
    
    func CardView(){
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
    }
}

extension UIButton{
    func BorderButton(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.deepBlue.cgColor
    }
    func LoginButton(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.orange.cgColor
        self.setTitleColor(UIColor.orange, for: .normal)
    }
}
