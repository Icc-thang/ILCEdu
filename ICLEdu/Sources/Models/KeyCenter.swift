//
//  APIHeader.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/10/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import SkeletonView

// baseURLAPI
let baseUrl:String = "https://townwork.vn/api/"

// baseURL for image + audio
let baseUrlMedia:String = "https://townwork.vn/"

let avatarBase = "https://i.imgur.com/wNZd7oZ.png"

// avatar
let avatar = UserDefaults.standard.string(forKey: "avatar")

// name
let name = UserDefaults.standard.string(forKey: "name")

//api provider
let apiProvider = MoyaProvider<APIRequest>()

//
let gradient = SkeletonGradient(baseColor: UIColor.colorGreen)
let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
