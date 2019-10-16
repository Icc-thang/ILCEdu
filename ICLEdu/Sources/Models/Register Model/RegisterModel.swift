//
//  RegisterModel.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/11/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import ObjectMapper

struct RegisterModel : Mappable {
    var access_token : String?
    var registered : Bool?
    var id : Int?
    var token_type : String?
    var expires_at : String?
    var message : String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        access_token <- map["access_token"]
        registered <- map["registered"]
        id <- map["id"]
        token_type <- map["token_type"]
        expires_at <- map["expires_at"]
        message <- map["message"]
    }
}
