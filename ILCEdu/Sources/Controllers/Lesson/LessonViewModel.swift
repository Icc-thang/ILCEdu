//
//  LessonViewModel.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class LessonViewModel: NSObject{
    
    let dataN5 = BehaviorSubject(value: [N5]())
    
    override init() {
        super.init()
        bindData()
    }
    
    private func bindData(){
        self.getDataForLesson()
    }

    func refreshData(_ id:Int?, _ vocab_position:Int?){
        self.postPosionVocab(id, vocab_position)
    }
    
    private func getDataForLesson(){
        apiProvider.rx.request(.getLessonData)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { resultJson in
                let dataArray = Mapper<Lesson>().map(JSONObject: resultJson)
                self.dataN5.onNext((dataArray?.n5)!)
            }).disposed(by: disposeBag)
    }
    
    private func postPosionVocab(_ id:Int?, _ vocab_position:Int?){
        apiProvider.rx.request(.lesson_vocab_position(id ?? 0, vocab_position ?? 0))
        .filterSuccessfulStatusCodes()
        .subscribe(onSuccess: { _ in
            print("Đẩy từ vựng vị trí \(vocab_position ?? 0) hoàn tất")
            self.getDataForLesson()
            print("Done refresh data!")
            }).disposed(by: disposeBag)
    }
    
    func percentLesson(lesson_finish:Int?, numberOfVocab: Int?, positionVocab: Int?) -> Double{
        if lesson_finish ?? 0 == 0{
            var percentPerVocab:Double?
            // tính phần trăm cho tổng số từ
            if numberOfVocab ?? 0 == 0 {
                percentPerVocab = 0
            }else {
                percentPerVocab = 100/Double(numberOfVocab ?? 0)
            }
            //tính phần trăm số từ hiện tại
            let totalPercent :Double = Double((positionVocab ?? 0)) * Double((percentPerVocab ?? 0))
            return totalPercent
        }else{
            let totalPercent :Double = Double(100)
            return totalPercent
        }
    }
}

