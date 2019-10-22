//
//  APIRequest.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/17/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya

enum APIRequest{
    case loginFB(tokenFB: String)
    case register(member_name: String, member_email:String, member_gender: String, member_address:String, member_birthday:String, member_phone:String)
    case getLessonData
    case getProfile
    case getVocab(lessonID:Int)
    case lesson_vocab_position(lessonID : Int, vocab_position:Int)
}

extension APIRequest:TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .loginFB(_):
            return "auth/login/facebook"
        case .register(_):
            return "auth/register/\(member_id)"
        case .getLessonData:
            return "lesson"
        case .getProfile:
            return "auth/user"
        case .getVocab(let lessonID):
            return "lesson/vocab/\(lessonID)"
        case .lesson_vocab_position(let lessonID, _):
            return "lesson/position/\(lessonID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginFB(_):
            return .post
        case .register(_):
            return .post
        case .lesson_vocab_position(_):
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .loginFB(let tokenFB):
            return ["social_token" : tokenFB]
        case .register(let name, let email,let gender, let address, let birthday, let phone):
            return ["name": name,"email": email, "gender":gender, "address": address, "birthday": birthday, "phone": phone]
        case .lesson_vocab_position(_, let vocab_position):
            return ["lesson_vocab_position": vocab_position]
        default:
            return ["" : ""]
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        switch self {
        case .loginFB(_):
            return ["Content-Type":"application/x-www-form-urlencoded"]
        case .register(_):
            return ["X-Requested-With":"XMLHttpRequest"]
        default:
            return ["Authorization": tokenHeader ]
        }
    }
}
