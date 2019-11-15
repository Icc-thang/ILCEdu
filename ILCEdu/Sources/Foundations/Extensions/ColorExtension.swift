
//
//  Color.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/24.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    //static color
    
    static let colorGreen = UIColor().colorFromHex("00C4A4")
    static let colorGray = UIColor().colorFromHex("8B8B8B")
    static let colorRed = UIColor().colorFromHex("D72031")
    static let colorBlue = UIColor().colorFromHex("4169E1")
    static let colorYellow = UIColor().colorFromHex("FFFC5D")
    
    func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        var RGB: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&RGB)
        
        return UIColor.init(red: CGFloat((RGB & 0xFF0000) >> 16)/255,
                            green: CGFloat((RGB & 0x00FF00) >> 8)/255,
                            blue: CGFloat(RGB & 0x0000FF)/255,
                            alpha: 1.0)
        
        
    }
}
