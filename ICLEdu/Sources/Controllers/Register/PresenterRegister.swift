//
//  PresenterModifyProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/2/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegateRegister:class {
    func getDataRegister()
}
class PresenterRegister {
    weak var delegateRegister: DelegateRegister?
    
    convenience init(delegate: DelegateRegister){
        self.init()
        self.delegateRegister = delegate
    }
    
    var registerModel : RegisterModel?
    
    func getDataForRegister(_ member_name: String,_ member_gender: String,_ member_email: String,
                            _ member_address: String, _ member_birthday: String,_ member_phone: String){
        
        apiProvider.rx.request(.register(member_name, member_email, member_gender, member_address, member_birthday, member_phone))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { json in
                self.registerModel = Mapper<RegisterModel>().map(JSONObject: json)
                self.delegateRegister?.getDataRegister()
            }) { (err) in
                print(err)
        }
    }
}
