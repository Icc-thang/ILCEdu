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
    
    fileprivate let refreshControl = UIRefreshControl()
    
    fileprivate var number: Int = 0
    
    fileprivate let presenterLesson = PresenterLesson()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenterLesson.getDataForLesson()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterLesson.delegateLesson = self
        navigationSetup()
        collectionViewSetUp()
        pullToRefreshData()
 
    }
    
    func navigationSetup(){
        let view = NaviView()
        view.setNavigationView(classLabel: tabLesson,
                               userAvatar: UserDefaults.standard.string(forKey: "avatar") ?? avatarBase)
        navigationItem.titleView = view
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func pullToRefreshData(){
        // Add Refresh Control to CollectionView
        if #available(iOS 10.0, *) {
            self.lessonCollectionView.refreshControl = refreshControl
        } else {
            self.lessonCollectionView.addSubview(refreshControl)
        }
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.refreshControl.tintColor = UIColor.lightGray
    }
    
    @objc private func updateData() {
        self.number += 1
        self.presenterLesson.getDataForLesson()
        self.refreshControl.endRefreshing()
    }
    
    func collectionViewSetUp(){
        //registerLessonNib
        lessonCollectionView.register(UINib(nibName: lesCell, bundle: nil), forCellWithReuseIdentifier: lesCell)
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lessonCell = collectionView.dequeueReusableCell(withReuseIdentifier: lesCell, for: indexPath) as! LessonCell
        
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
        return CGSize.init(width: width , height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vocabularyVC = UIStoryboard.init(name: vocabularyController, bundle: nil).instantiateViewController(withIdentifier: vocabularyController) as? VocabularyViewController
        
        var position:Int?
        var finish:Int?
        if presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?.isEmpty == true{
            finish = 0
            position = 0
        }else{
            finish = presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?[0].lesson_finish ?? 0
            position = presenterLesson.lesson?.n5?[indexPath.row].app_member_statistical?[0].lesson_vocab_position ?? 0
        }
        
        vocabularyVC?.getKeyFromLesson(
            nameLesson: presenterLesson.lesson?.n5?[indexPath.row].name ?? "",
            vocabCount: presenterLesson.lesson?.n5?[indexPath.row].app_vocab_count ?? 0,
            idLesson: presenterLesson.lesson?.n5?[indexPath.row].id ?? 0,
            postionVocab: position ?? 0,
            finish: finish ?? 0 )
        
        vocabularyVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vocabularyVC!, animated: true)
    }
}
