//
//  VocabularyPresenter.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/27.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
protocol DelegateVocabulary:class {
    
}
class PresenterVocabulary{
    weak var delegateVocabulary: DelegateVocabulary?
    
    var numberOfVocab:Int? = 30
    var positionOfVocab:Int?
    
    convenience init(delegate : DelegateVocabulary){
        self.init()
        self.delegateVocabulary = delegate
    }
    
}
