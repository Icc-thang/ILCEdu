//
//  ButtonExtension.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/4/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func BorderButton(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.colorGreen.cgColor
        self.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func FacebookButton(){
        self.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func LoginButton(){
        self.layer.backgroundColor = UIColor.orange.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.orange.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
