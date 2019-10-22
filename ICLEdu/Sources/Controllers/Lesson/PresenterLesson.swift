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
    
    let lessonProvider = MoyaProvider<APIRequest>()
    var lesson: Lesson?
    
    func getDataForLesson(){
        lessonProvider.request(.getLessonData) { (result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<Lesson>().map(JSONObject: json)
                        else{
                            return
                    }
                    self.lesson = dataJSON
                    self.delegateLesson?.getDataLesson()
                    print(dataJSON)
                }catch{
                    print("Lỗi tải về danh sách bài học")
                }
            case .failure(let error):
                print("Nội dung lỗi: \(error)")
            }
        }
    }
    
}
