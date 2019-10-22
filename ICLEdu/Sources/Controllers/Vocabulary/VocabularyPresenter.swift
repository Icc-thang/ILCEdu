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
    
    convenience init(delegate : DelegateVocabulary){
        self.init()
        self.delegateVocabulary = delegate
    }
    
    var nameLesson: String?
    var vocabCount:Int?
    var idLesson:Int?
    var positionVocab:Int?
    
    func keyFromLesson(nameLesson: String, vocabCount:Int, idLesson:Int, positionVocab:Int?){
        self.nameLesson = nameLesson
        self.vocabCount = vocabCount
        self.idLesson = idLesson
        self.positionVocab = positionVocab
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
                    print("Lỗi tải về danh sách từ vựng")
                }
            case .failure(let error):
                print("Nội dung lỗi: \(error)")
            }
        }
    }
    
    func postPosionVocab(vocab_position:Int){
        vocabProvider.request(.lesson_vocab_position(lessonID: idLesson ?? 0, vocab_position: vocab_position)) {(result) in
            switch result {
            case .success(_):
                print("Đẩy vị trí từ vựng hoàn tất")
            case .failure(let error):
                print("Nội dung lỗi: \(error)")
            }
        }
    }
}
