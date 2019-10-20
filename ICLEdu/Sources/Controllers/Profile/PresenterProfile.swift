//
//  PresenterProfile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/12/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegateProfile:class {
    func getDataProfile()
}
class PresenterProfile {
    weak var delegateProfile: DelegateProfile?
    
    convenience init(delegate: DelegateProfile){
        self.init()
        self.delegateProfile = delegate
    }
    
    let profileProvider = MoyaProvider<APIRequest>()
    
    var profileModel : ProfileModel?
    
    func getDataForProfile(){
        profileProvider.request(.getProfile){ (result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<ProfileModel>().map(JSONObject: json)
                        else{
                            return
                    }
                    self.profileModel = dataJSON
                    self.delegateProfile?.getDataProfile()
                    print("profile data: \(dataJSON)")
                }catch{
                    print("error get data Profile")
                }
            case .failure(_):
                print("Fail connect")
            }
        }
    }
}
