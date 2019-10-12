//
//  APIHeader.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
//
let baseUrl:String = "https://townwork.vn/api/auth"

//meberID
var member_ID:Int?

//Access Token
let token = UserDefaults.standard.string(forKey: "authorization")
// for Header ->
let tokenDB = "Bearer \(token ?? "")"

//profile Data
var profileData:ProfileModel?

