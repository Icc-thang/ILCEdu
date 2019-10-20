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
    
    let loginProvider = MoyaProvider<APIRequest>()
    
    var loginModel : LoginFBModel?
    
    func getDataForLogin(tokenFB : String?){
        loginProvider.request(.loginFB(tokenFB: tokenFB ?? "")) { (result) in
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
                    print("error get Data Login")
                }
            case .failure(let err):
                print("Nội dung lỗi đăng nhập Facebook: \(err)")
            }
        }
    }
}
