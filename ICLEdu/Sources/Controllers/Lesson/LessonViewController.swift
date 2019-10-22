//
//  LessonViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class LessonViewController: UIViewController {
    
    @IBOutlet weak var lessonCollectionView: UICollectionView!
    
    let presenterLesson = PresenterLesson()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenterLesson.getDataForLesson()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterLesson.delegateLesson = self
        print(tokenHeader)
        collectionViewSetUp()
    }
    
    func collectionViewSetUp(){
        //registerNavNib
        let navCell = UINib(nibName: "NavCell", bundle: nil)
        lessonCollectionView.register(navCell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NavCell")
        //registerHeaderLessonNib
        let headerLessonCell = UINib(nibName: "HeaderLessonCell", bundle: nil)
        lessonCollectionView.register(headerLessonCell, forCellWithReuseIdentifier: "HeaderLessonCell")
        //registerLessonNib
        let lessonCell = UINib(nibName: "LessonCell", bundle: nil)
        lessonCollectionView.register(lessonCell, forCellWithReuseIdentifier: "LessonCell")
    }
}

extension LessonViewController: DelegateLesson {
    func getDataLesson() {
        lessonCollectionView.reloadData()
    }
}

extension LessonViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenterLesson.lesson?.n5?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            
            let navCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NavCell", for: indexPath) as! NavCell
            navCell.parseDataForNav(userName: name, userImageUrl: avatar)
            return navCell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lessonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonCell", for: indexPath) as! LessonCell
        
        var position:Int?
        var finish:Int?
        if presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?.isEmpty == true{
            finish = 0
            position = 0
        }else{
            finish = presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?[0].lesson_finish ?? 0
            position = presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?[0].lesson_vocab_position ?? 0
        }
        
        lessonCell.parseDataLessonCell(
            imgURL: presenterLesson.lesson?.n5?[indexPath.row].image,
            name: presenterLesson.lesson?.n5?[indexPath.row].name,
            title: presenterLesson.lesson?.n5?[indexPath.row].title,
            lesson_finish: finish,
            numberOfVocab: presenterLesson.lesson?.n5?[indexPath.row].app_vocab_count ?? 0,
            positionVocab: position)
    
        return lessonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 16)
        //        let height = (collectionView.frame.size.height / 2)
        return CGSize.init(width: width , height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vocabularyVC = UIStoryboard.init(name: "VocabularyController", bundle: nil).instantiateViewController(withIdentifier: "VocabularyController") as? VocabularyViewController
        var position:Int?
        if presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?.isEmpty == true{
            position = 0
        }else{
            position = presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?[0].lesson_vocab_position ?? 0
        }
        
        vocabularyVC?.getKeyFromLesson(
            nameLesson: presenterLesson.lesson?.n5?[indexPath.row].name ?? "",
            vocabCount: presenterLesson.lesson?.n5?[indexPath.row].app_vocab_count ?? 0,
            idLesson: presenterLesson.lesson?.n5?[indexPath.row].id ?? 0,
            postionVocab: position ?? 1)
        
        vocabularyVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vocabularyVC!, animated: true)
    }
}
