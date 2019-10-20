//
//  VocabularyPresenter.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/27.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegateVocabulary:class {
    func getListVocab()
}

class PresenterVocabulary{
    weak var delegateVocabulary: DelegateVocabulary?
    
    var positionOfVocab:Int?
    
    convenience init(delegate : DelegateVocabulary){
        self.init()
        self.delegateVocabulary = delegate
    }
    var vocabCount:Int?
    var idLesson:Int?
    
    func keyFromLesson(vocabCount:Int, idLesson:Int){
        self.vocabCount = vocabCount
        self.idLesson = idLesson
    }
    
    let vocabProvider = MoyaProvider<APIRequest>()
    var vocabList: [VocabularyModel]?
    
    func getVocabList(){
        vocabProvider.request(.getVocab(lessonID: idLesson ?? 0)) {(result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<VocabularyModel>().mapArray(JSONObject: json)
                        else{
                            return
                    }
                    print(dataJSON)
                    self.vocabList = dataJSON
                    self.delegateVocabulary?.getListVocab()

                }catch{
                    print("error get Data Lesson")
                }
            case .failure(let error):
                print("Nội dung lỗi: \(error)")
            }
        }
    }
}
