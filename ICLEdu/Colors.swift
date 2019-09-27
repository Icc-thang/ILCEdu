//
//  Colors.swift
//  CockBook
//
//  Created by Ta Tuan Macbook on 3/26/19.
//  Copyright © 2019 HiUPTeam. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    //static color
    
    static let deepGreen = UIColor().colorFromHex("7ED321")
    static let deepGray = UIColor().colorFromHex("8B8B8B")
    static let deepRed = UIColor().colorFromHex("D72031")
    
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
