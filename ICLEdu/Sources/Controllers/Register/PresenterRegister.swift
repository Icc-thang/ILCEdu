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
    
    var avatarURL: String?
    var fullName: String?
    var email: String?
    var ID: Int?
    
    func setProfileFBData(avatar:String?, name:String?, email:String?, memberID:Int?)  {
        self.avatarURL = avatar
        self.fullName = name
        self.email = email
        self.ID = memberID
    }
    
    let registerProvider = MoyaProvider<RegisterRequest>()

    var registerModel : RegisterModel?

    func getDataForRegister(member_name: String, member_gender: String, member_email:String, member_address:String, member_birthday:String, member_phone:Int){

        registerProvider.request(.register(member_name: member_name, member_email: member_email, member_gender: member_gender, member_address: member_address, member_birthday: member_birthday, member_phone: member_phone)) { (result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<RegisterModel>().map(JSONObject: json)
                        else{
                            return
                    }
                    self.registerModel = dataJSON
                    self.delegateRegister?.getDataRegister()
                    print(dataJSON)
                }catch{
                    print("error get Data")
                }
            case .failure(_):
                print("Fail connect")
            }
        }
    }
}
