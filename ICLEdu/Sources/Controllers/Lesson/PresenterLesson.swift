//
//  LessonPresenter.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/16/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegateLesson:class {
    func getDataLesson()
}

class PresenterLesson {
    weak var delegateLesson: DelegateLesson?
    
    convenience init(delegate: DelegateLesson){
        self.init()
        self.delegateLesson = delegate
    }
    
    var lesson: Lesson?
    
    func getDataForLesson(){
        apiProvider.rx.request(.getLessonData)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .do(onError: { error in
                print(error)
            })
            .subscribe(onSuccess: { json in
                self.lesson = Mapper<Lesson>().map(JSONObject: json)
                self.delegateLesson?.getDataLesson()
            }) { (error) in
                print(error)
        }
    }
}
