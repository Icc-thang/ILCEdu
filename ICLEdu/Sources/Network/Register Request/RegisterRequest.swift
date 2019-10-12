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
    case register(member_name: String, member_email:String, member_gender: String, member_address:String, member_birthday:String, member_phone:Int)
}

extension RegisterRequest: TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .register(_):
            return "register/\(member_ID ?? 0)"
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
    
    var task: Task {
        switch self {
        case .register(let member_name, let member_email, let member_gender, let member_address, let member_birthday, let member_phone):
            
            return .requestParameters(parameters: ["name": member_name,"email": member_email, "gender":member_gender, "address": member_address, "birthday": member_birthday, "phone": member_phone], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Requested-With":"XMLHttpRequest"]
    }
    
}
