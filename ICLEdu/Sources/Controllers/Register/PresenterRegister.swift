//
//  PresenterModifyProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/2/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation

protocol DelegateRegister:class {
    
}
class PresenterRegister {
    weak var delegateRegister: DelegateRegister?
    
    convenience init(delegate: DelegateRegister){
        self.init()
        self.delegateRegister = delegate
    }
    
    var avatarURL: String?
    var fullName: String?
    var email: String?
    var fbID: String?
    
    func getProfileFBData(avatar:String?, name:String?, email:String?, fbID:String?)  {
        self.avatarURL = avatar
        self.fullName = name
        self.email = email
        self.fbID = fbID
    }
}
