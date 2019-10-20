//
//  LessonModel.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/16/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import ObjectMapper

struct Lesson:Mappable {
    
    var n5 : [LessonModel]?
//    var n4 : [LessonModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        n5 <- map["N5"]
//        n4 <- map["N4"]
    }
}

struct LessonModel : Mappable {
    var lesson_id : Int?
    var vocab_name : String?
    var vocab_image : String?
    var vocab_title : String?
    var vocab_level : String?
    var vocab_count : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lesson_id <- map["id"]
        vocab_name <- map["name"]
        vocab_image <- map["image"]
        vocab_title <- map["title"]
        vocab_level <- map["level"]
        vocab_count <- map["app_vocab_count"]
    }
    
}
