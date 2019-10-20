//
//  VocabularyViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

let vocabularyCell = "VocabularyCell"
let cardCell = "CardCell"
class VocabularyViewController: UIViewController{
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPrev: UIButton!
    
    @IBOutlet weak var collectionVocab: UICollectionView!
    
    @IBOutlet weak var progressPercent: LinearProgressView!
    
    private let presenterVocabulary = PresenterVocabulary()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterVocabulary.delegateVocabulary = self
        presenterVocabulary.getVocabList()
        setupProgress()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("BACK")
    }
    
    func setupProgress(){
        progressPercent.trackColor = UIColor.colorGreen
        progressPercent.maximumValue = Float(presenterVocabulary.vocabCount ?? 0)
        progressPercent.setProgress(Float(postionVocab), animated: true)
    }
    
    func getNameLesson(nameLesson: String){
        self.navigationItem.title = "\(nameLesson)"
    }
    
    func getKeyFromLesson(vocabCount:Int, idLesson:Int){
        presenterVocabulary.keyFromLesson(vocabCount: vocabCount, idLesson: idLesson)
    }
    
    func setupUI(){
        buttonPrev.BorderButton()
        buttonNext.BorderButton()
        //
        collectionVocab.register(UINib(nibName: vocabularyCell, bundle: nil), forCellWithReuseIdentifier: vocabularyCell)
        collectionVocab.isPagingEnabled = true
        collectionVocab.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = presenterVocabulary.vocabCount ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
        handleNextPage(button: buttonPrev)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        handleNextPage(button: buttonNext)
    }
    
    let postionVocab: Int = 1
    
    @objc func handleNextPage(button: UIButton) {
        var indexPath: IndexPath!
        var current = pageControl.currentPage
        
        if button.tag == 0 {
            current -= 1
//            progressPercent.setProgress(Float(postionVocab + current), animated: true)
            if current < 0 {
                current = 0
            }
        } else {
            current += 1
            progressPercent.setProgress(Float(1 + current), animated: true)
            if current == presenterVocabulary.vocabCount {
                current = (presenterVocabulary.vocabCount ?? 0) - 1
            }
        }
        
        indexPath = IndexPath(item: current, section: 0)
        collectionVocab.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

}

extension VocabularyViewController: DelegateVocabulary{
    func getListVocab() {
        collectionVocab.reloadData()
    }
}

extension VocabularyViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenterVocabulary.vocabCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indexP = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vocabularyCell, for: indexPath) as! VocabularyCell
        cell.setDataForVocabularyCell(
            imageCard: self.presenterVocabulary.vocabList?[indexPath.row].vocab_image,
            japanese: self.presenterVocabulary.vocabList?[indexPath.row].vocab_jp,
            kanji: self.presenterVocabulary.vocabList?[indexPath.row].vocab_kanji,
            example: self.presenterVocabulary.vocabList?[indexPath.row].vocab_example,
            vietnamVocab: self.presenterVocabulary.vocabList?[indexPath.row].vocab_vi,
            audioLink: self.presenterVocabulary.vocabList?[indexPath.row].vocab_audio
            )

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
