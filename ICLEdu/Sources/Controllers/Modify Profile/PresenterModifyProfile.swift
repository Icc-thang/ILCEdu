//
//  PresenterModifyProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/2/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation

protocol DelegateModifyProfile:class {
    
}
class PresenterModifyProfile {
    weak var delegateModify: DelegateModifyProfile?
    
    convenience init(delegate: DelegateModifyProfile){
        self.init()
        self.delegateModify = delegate
    }
    
    var avatarURL: String?
    var fullName: String?
    
    func getProfileFBData(avatar:String?, name:String?)  {
        avatarURL = avatar
        fullName = name
    }
}
