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
    func ifLoginError()

}
class PresenterLogin{
    weak var delegateLogin : LoginDelegate?
    
    convenience init(delegate: LoginDelegate){
        self.init()
        self.delegateLogin = delegate
    }
    
    var loginModel : LoginFBModel?
    
    func getDataForLogin(tokenFB : String?){
        apiProvider.rx.request(.loginFB(tokenFB ?? ""))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(
                onSuccess: { json in
                    self.loginModel = Mapper<LoginFBModel>().map(JSONObject: json)
                    self.delegateLogin?.getDataLogin()
                    print("Log In:\(json)")
            }) { (error) in print(error)
                self.delegateLogin?.ifLoginError()
        }
    }
}
