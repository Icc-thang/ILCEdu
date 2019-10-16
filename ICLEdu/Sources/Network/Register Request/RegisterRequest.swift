//
//  RegisterRequest.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/11/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya

enum RegisterRequest{
    case register(member_name: String, member_email:String, member_gender: String, member_address:String, member_birthday:String, member_phone:String)
}

extension RegisterRequest: TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .register(_):
            return "auth/register/\(member_id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
     
    var parameters: [String: Any]? {
        switch self {
        case .register(let name, let email,let gender, let address, let birthday, let phone):
            return ["name": name,"email": email, "gender":gender, "address": address, "birthday": birthday, "phone": phone]
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .register(_):
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Requested-With":"XMLHttpRequest"]
    }
    
}
