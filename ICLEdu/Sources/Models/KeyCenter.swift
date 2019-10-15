//
//  APIHeader.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation

// baseURLAPI
let baseUrl:String = "https://townwork.vn/api"

// avatar
let avatar = UserDefaults.standard.string(forKey: "avatar")

// name
let name = UserDefaults.standard.string(forKey: "name")

// access Token
let tokenFacebook = UserDefaults.standard.string(forKey: "authorization")

// for Header ->
let tokenDatabase = "Bearer \(tokenFacebook ?? "")"

// baseURL for image + audio
let baseUrlMedia:String = "https://townwork.vn/"

//profile Data
var profileData:ProfileModel?

