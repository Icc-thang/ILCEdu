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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterLesson.delegateLesson = self
        presenterLesson.getDataForLesson()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let roationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 10, 0)
        cell.alpha = 0
        cell.layer.transform = roationTransform
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    
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
        lessonCell.parseDataLessonCell(
            imgURL: presenterLesson.lesson?.n5?[indexPath.row].vocab_image,
            name: presenterLesson.lesson?.n5?[indexPath.row].vocab_name,
            title: presenterLesson.lesson?.n5?[indexPath.row].vocab_title,
            numberOfVocab: presenterLesson.lesson?.n5?[indexPath.row].vocab_count)
        return lessonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 16)
//        let height = (collectionView.frame.size.height / 2)
        return CGSize.init(width: width , height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vocabularyVC = UIStoryboard.init(name: "VocabularyController", bundle: nil).instantiateViewController(withIdentifier: "VocabularyController") as? VocabularyViewController
        vocabularyVC?.getNameLesson(nameLesson: presenterLesson.lesson?.n5?[indexPath.row].vocab_name ?? "")
        vocabularyVC?.getKeyFromLesson(vocabCount: presenterLesson.lesson?.n5?[indexPath.row].vocab_count ?? 0, idLesson: presenterLesson.lesson?.n5?[indexPath.row].lesson_id ?? 0)
        vocabularyVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vocabularyVC!, animated: true)
        
    }
}
