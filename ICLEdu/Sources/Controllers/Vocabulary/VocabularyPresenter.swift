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
    var percentOf1Vocab: Float?
    var totalPercent:Float?
    
    func keyFromLesson(nameLesson: String, vocabCount:Int, idLesson:Int, positionVocab:Int, finish:Int){
        self.nameLesson = nameLesson
        self.vocabCount = vocabCount
        self.idLesson = idLesson
        self.positionVocab = positionVocab
        self.percentOf1Vocab = 100/(Float(vocabCount))
        if finish == 0{
            if vocabCount == 0 {
                percentOf1Vocab = 0
            }
            //tính phần trăm số từ hiện tại
            self.totalPercent = (Float(positionVocab)) * (percentOf1Vocab ?? 0)
        }else{
            self.totalPercent = 100
        }
    }
    
    var vocabList: [VocabularyModel]?
    
    func getVocabList(){
        apiProvider.rx.request(.getVocab(idLesson ?? 0))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { json in
                self.vocabList = Mapper<VocabularyModel>().mapArray(JSONObject: json)
                self.delegateVocabulary?.getListVocab()
            }){ (error) in
                print(error)
        }
    }
    
    func postPosionVocab(vocab_position:Int?){
        apiProvider.rx.request(.lesson_vocab_position(idLesson ?? 0, vocab_position ?? 0))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { json in
                print("Đẩy từ vựng vị trí \(vocab_position ?? 0) ở bài \(self.idLesson ?? 0) hoàn tất")
            }){ (error) in
                print(error)
        }
    }
}
