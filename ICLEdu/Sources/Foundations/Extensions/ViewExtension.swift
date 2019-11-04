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

extension UIView{
    func FacebookButton(){
        self.layer.cornerRadius = 5
    }
}

//Image Extension
@IBDesignable
class CircleAvatar: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
}
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
    
    func CardImage(){
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
    }
}

//Button Extension
extension UIButton{
    func BorderButton(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.colorGreen.cgColor
        self.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func LoginButton(){
        self.layer.backgroundColor = UIColor.orange.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.orange.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
}


//Spinner Extension
var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func alertError(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(close)
        self.present(alertController, animated: true, completion: nil)
    }
}
