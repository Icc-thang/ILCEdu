//
//  MenuCell.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/17/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuImage.CircleImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDataForMenu(menuSource:String?, title:String?){
        menuImage.sd_setImage(with: URL(string:"\(menuSource ?? "")"))
        titleLabel.text = title ?? ""
    }
    func setImageWithAccess(menuSource:String?,title:String?){
        menuImage.image = UIImage(named: menuSource!)
        titleLabel.text = title ?? ""
    }
}
