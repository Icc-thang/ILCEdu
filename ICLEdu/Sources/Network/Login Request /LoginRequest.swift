//
//  File.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya

enum LoginRequest{
    case loginFB(tokenFB: String)
}

extension LoginRequest: TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .loginFB(_):
            return "login/facebook"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginFB(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .loginFB(let tokenFB):
            return .requestParameters(parameters: ["social_token" : tokenFB], encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
}
