//
//  ProfileRequest.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/12/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya

enum ProfileRequest{
    case getProfile
}
extension ProfileRequest:TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProfile:
            return .requestParameters(parameters: ["" : ""], encoding: URLEncoding.default)
        }
    }
    
    
    var headers: [String : String]? {
        return ["Authorization": tokenDatabase ]
    }
    
    
}
