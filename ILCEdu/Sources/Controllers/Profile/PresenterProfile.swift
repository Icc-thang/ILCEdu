//
//  PresenterProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/24/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

protocol DelegateProfile: class {
    func getUserData()
}

class ProfilePresenter {
    weak var delegate: DelegateProfile?
    
    convenience init(delegate : DelegateProfile){
        self.init()
        self.delegate = delegate
    }
    
    var profileModel: ProfileModel?
    
    func requestProfile(){
        apiProvider.rx.request(.getProfile)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                print(json)
                self.profileModel = Mapper<ProfileModel>().map(JSONObject: json)
                self.delegate?.getUserData()
            }){ (error) in
                print(error)
        }
    }
}
