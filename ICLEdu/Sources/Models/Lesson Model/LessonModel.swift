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
    
    var n5 : [N5]?
//    var n4 : [LessonModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        n5 <- map["N5"]
//        n4 <- map["N4"]
    }
}

struct N5 : Mappable {
    var id : Int?
    var name : String?
    var image : String?
    var title : String?
    var level : String?
    var app_vocab_count : Int?
    var app_member_statistical : [App_member_statistical]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        title <- map["title"]
        level <- map["level"]
        app_vocab_count <- map["app_vocab_count"]
        app_member_statistical <- map["app_member_statistical"]
    }

}

struct App_member_statistical : Mappable {
    var member_id : Int?
    var lesson_id : Int?
    var lesson_vocab_position : Int?
    var lesson_finish : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        member_id <- map["member_id"]
        lesson_id <- map["lesson_id"]
        lesson_vocab_position <- map["lesson_vocab_position"]
        lesson_finish <- map["lesson_finish"]
    }

}
