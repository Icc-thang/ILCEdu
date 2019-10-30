//
//  PresenterPractice.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/30/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

protocol DelegatePractice:class {
    
}

class PresenterPractice {
    weak var delegatePractice: DelegatePractice?
    
    convenience init(delegate: DelegatePractice){
        self.init()
        self.delegatePractice = delegate
    }
    
}
