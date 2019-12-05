//
//  NaviView.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/15/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class NaviView: UIView{
    
    @IBOutlet var naviView: UIView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var userAvatar: CircleAvatar!
    
    override init(frame: CGRect){
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("NaviView", owner: self, options: nil)
        addSubview(naviView)
        naviView.frame = self.bounds
        naviView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    func setNavigationView(classLabel: String, userAvatar:String)    {
        self.classLabel.text = classLabel
        self.userAvatar.sd_setImage(with: URL(string: userAvatar ?? avatarBase))
    }
}
