//
//  VocabViewModel.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper

class VocabViewModel : NSObject{
    var lessonID = PublishRelay<Int>()
    var vocabData = BehaviorSubject(value: [VocabularyModel]())
    var id:Int?
    var percent:Double?
    var lessonName:String?
    var position:Int?
    var vocabCount:Int?
    var percentage:Float?
    
    override init() {
        super.init()
        bindData()
    }
    
    func setId(_ Id:Int?){
        self.id = Id
    }
    
    func setPercent(_ percent:Double){
        self.percent = percent
    }
    
    func setLessonName(_ lessonName: String){
        self.lessonName = lessonName
    }
    
    func setVocabPosition(_ position: Int){
        self.position = position
    }
    
    func setVocabCount(_ vocabCount: Int){
        self.vocabCount = vocabCount
        self.percentage = 100/(Float(vocabCount))
    }
    
    func bindData(){
        lessonID.asObservable().subscribe(onNext: { id in
            if id != 0{
                self.getVocabData(id)
            }
        }).disposed(by: disposeBag)
    }
    var vocabList:[VocabularyModel]?
    
    func getVocabData(_ lesson_id:Int){
        apiProvider.rx.request(.getVocab(lesson_id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { json in
                self.vocabList = Mapper<VocabularyModel>().mapArray(JSONObject: json)
                self.vocabData.onNext(self.vocabList!)
            }).disposed(by: disposeBag)
    }
}
