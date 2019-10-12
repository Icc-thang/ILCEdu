//
//  ProfileModel.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/12/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileModel : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var avatar : String?
    var phone : Int?
    var gender : String?
    var birthday : String?
    var address : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        avatar <- map["avatar"]
        phone <- map["phone"]
        gender <- map["gender"]
        birthday <- map["birthday"]
        address <- map["address"]
    }

}
