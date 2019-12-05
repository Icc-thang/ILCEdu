//
//  LessonViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class LessonViewController: UICollectionViewController{
    
    private let vm = LessonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        print("Bearer \(UserDefaults.standard.string(forKey: "authorization")!)")
        navigationSetup()
        bindUI()
        bindViewModel()
    }
    
    private func bindUI(){
        collectionView.register(UINib(nibName: lesCell, bundle: nil), forCellWithReuseIdentifier: lesCell)
        
        let flowLayout = UICollectionViewFlowLayout()
        let size = (collectionView.frame.size.width - CGFloat(16))
        flowLayout.itemSize = CGSize(width: size, height: size)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    private func bindViewModel(){
        
        vm.dataN5
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: lesCell,cellType: LessonCell.self)){ (index,model,cell) in
                print(model)
                var position:Int?
                var finish:Int?
                if model.app_member_statistical?.isEmpty == true{
                    finish = 0
                    position = 0
                }else{
                    finish = model.app_member_statistical?[0].lesson_finish ?? 0
                    position = model.app_member_statistical?[0].lesson_vocab_position ?? 0
                }
                cell.parseDataLessonCell(imgURL: model.image,name: model.name, title: model.title,
                                         totalPercent: self.vm.percentLesson(lesson_finish: finish, numberOfVocab: model.app_vocab_count ?? 0, positionVocab: position))
        }.disposed(by: disposeBag)
        
        self.collectionView.rx
            .modelSelected(N5.self)
            .subscribe(onNext: { (model) in
                let vocabularyVC = UIStoryboard.init(name: vocabController, bundle: nil)
                    .instantiateViewController(withIdentifier: vocabController) as? VocabViewController
                var position:Int?
                var finish:Int?
                if model.app_member_statistical?.isEmpty == true{
                    finish = 0
                    position = 0
                }else{
                    finish = model.app_member_statistical?[0].lesson_finish ?? 0
                    position = model.app_member_statistical?[0].lesson_vocab_position ?? 0
                }
                vocabularyVC?.lessonVC = self
                vocabularyVC?.initData(lessonID: model.id ?? 0, percent: self.vm.percentLesson(lesson_finish: finish, numberOfVocab: model.app_vocab_count ?? 0, positionVocab: position), lessonName: model.name ?? "", position: position ?? 0, vocabCount: model.app_vocab_count ?? 0)
                
                vocabularyVC?.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vocabularyVC!, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func setPosition(_ id:Int, _ positionVocab: Int){
        vm.refreshData(id, positionVocab)
    }
    
    private func navigationSetup(){
        let view = NaviView()
        view.setNavigationView(classLabel: tabLesson,
                               userAvatar: UserDefaults.standard.string(forKey: "avatar") ?? avatarBase)
        navigationItem.titleView = view
        navigationController?.navigationBar.isTranslucent = false
    }
}
