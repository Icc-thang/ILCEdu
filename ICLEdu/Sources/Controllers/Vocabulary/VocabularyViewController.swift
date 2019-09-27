//
//  VocabularyViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class VocabularyViewController: UIViewController {
    
    @IBOutlet weak var progressPercent: LinearProgressView!
    private let presenterVocabulary = PresenterVocabulary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterVocabulary.delegateVocabulary = self as? DelegateVocabulary
        setupUI()
    }
    
    func setupUI(){
        progressPercent.maximumValue = Float(presenterVocabulary.numberOfVocab ?? 0)
        progressPercent.setProgress(Float(5), animated: true)
    }
    
    func getNameLesson(nameLesson: String){
        self.navigationItem.title = "\(nameLesson)"
    }
}
