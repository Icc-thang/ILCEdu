//
//  PresenterProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/24/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation

protocol DelegateProfile:class {
    
}

class PresenterProfile {
    weak var delegateProfile: DelegateProfile?
    
    convenience init(delegate: DelegateProfile){
        self.init()
        self.delegateProfile = delegate
    }
    
    var profileModel : ProfileModel?
    
    func getProfileModel(profileModel : ProfileModel?){
        self.profileModel = profileModel
    }
    
}
