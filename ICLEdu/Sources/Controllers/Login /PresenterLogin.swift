//
//  LoginPresenter.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol LoginDelegate:class {
    func getDataLogin()
}
class PresenterLogin{
    weak var delegateLogin : LoginDelegate?
    
    convenience init(delegate: LoginDelegate){
        self.init()
        self.delegateLogin = delegate
    }

    let loginProvider = MoyaProvider<LoginRequest>()
    
    var loginModel : LoginFBModel?
    
    var name:String?
    var email:String?
    var avatar:String?
    
    func facebookData(avatar: String , name: String, email: String){
        self.name = name
        self.email = email
        self.avatar = avatar
    }
    
    func getDataForLogin(tokenFB : String?){
        print(tokenFB ?? "token nil")
        loginProvider.request(LoginRequest.loginFB(tokenFB: tokenFB ?? "token FB không tồn tại")) { (result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<LoginFBModel>().map(JSONObject: json)
                        else{
                            return
                    }
                    self.loginModel = dataJSON
                    self.delegateLogin?.getDataLogin()
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
