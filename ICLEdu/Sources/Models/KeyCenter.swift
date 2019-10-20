//
//  APIHeader.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation

// baseURLAPI
let baseUrl:String = "https://townwork.vn/api/"

// avatar
let avatar = UserDefaults.standard.string(forKey: "avatar")

//ID User
let member_id = UserDefaults.standard.integer(forKey: "ID")

// name
let name = UserDefaults.standard.string(forKey: "name")

// for Header ->
let tokenHeader = "Bearer \(UserDefaults.standard.string(forKey: "authorization") ?? "")"

// baseURL for image + audio
let baseUrlMedia:String = "https://townwork.vn/"

