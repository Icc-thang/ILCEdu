//
//  VocabViewController.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import AVFoundation

class VocabViewController: UIViewController {
    
    @IBOutlet weak var vocabCollectionView: UICollectionView!
    
    @IBOutlet weak var progressPercent: LinearProgressView!
    
    fileprivate let vm = VocabViewModel()
    
    fileprivate let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    var lessonVC:LessonViewController?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let positionVocab = pageControl.currentPage + 1
        if positionVocab > vm.position! {
            lessonVC?.setPosition(vm.id ?? 0, positionVocab)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vocabCollectionView.delegate = nil
        vocabCollectionView.dataSource = nil
        self.vocabCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        bindUI()
        bindViewModel()
    }
    
    func initData(lessonID:Int, percent: Double, lessonName: String, position: Int, vocabCount:Int){
        let id = Observable.just(lessonID)
        id.asObservable().bind(to: vm.lessonID).disposed(by: disposeBag)
        vm.setId(lessonID)
        vm.setPercent(percent)
        vm.setLessonName(lessonName)
        vm.setVocabPosition(position)
        vm.setVocabCount(vocabCount)
    }
    
    func bindUI(){
        //register NIB
        vocabCollectionView.register(UINib(nibName: vocabCell, bundle: nil), forCellWithReuseIdentifier: vocabCell)
        
        self.navigationItem.title = vm.lessonName
        pageControl.numberOfPages = vm.vocabCount ?? 0
        //collection view setup
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        vocabCollectionView.showsHorizontalScrollIndicator = false
        vocabCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        //
        progressSetup()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func bindViewModel(){
        vm.vocabData.asObservable()
            .bind(to: vocabCollectionView.rx.items(cellIdentifier: vocabCell, cellType: VocabCell.self)){ (index, model, cell) in
                cell.setModel(model)
        }.disposed(by: disposeBag)
    }
    
    func progressSetup(){
        progressPercent.trackColor = UIColor.colorGreen
        progressPercent.maximumValue = Float(100)
        progressPercent.setProgress(Float(1 * vm.percentage!), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        progressPercent.setProgress((Float(scrollPos + 1) * (vm.percentage ?? 0)), animated: true)
        pageControl.currentPage = Int(scrollPos)
    }
    
}

extension VocabViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: screenWidth, height: height)
    }
}
