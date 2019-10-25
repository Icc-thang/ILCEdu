//
//  PresenterMenu.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/23/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegateMenu:class {
    
}

class PresenterMenu {
    weak var delegateMenu: DelegateMenu?
    
    convenience init(delegate: DelegateMenu){
        self.init()
        self.delegateMenu = delegate
    }
    
    var profileModel : ProfileModel?
    
    func getDataForProfile(){
        apiProvider.rx.request(.getProfile)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                print(json)
                self.profileModel = Mapper<ProfileModel>().map(JSONObject: json)
            }){ (error) in
                print(error)
        }
    }
}
