//
//  VocabularyModel.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/18/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import ObjectMapper

struct VocabularyModel : Mappable {
    
    var vocab_jp : String?
    var vocab_vi : String?
    var vocab_kanji : String?
    var vocab_example : String?
    var vocab_image : String?
    var vocab_audio : String?
    var lesson_id : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        vocab_jp <- map["vocab_jp"]
        vocab_vi <- map["vocab_vi"]
        vocab_kanji <- map["vocab_kanji"]
        vocab_example <- map["example"]
        vocab_image <- map["image"]
        vocab_audio <- map["audio"]
        lesson_id <- map["lesson_id"]
    }
    
}

