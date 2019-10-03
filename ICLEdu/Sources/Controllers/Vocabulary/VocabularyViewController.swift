//
//  VocabularyViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class VocabularyViewController: UIViewController,UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var collectionVocab: UICollectionView!
    @IBOutlet weak var progressPercent: LinearProgressView!
    private let presenterVocabulary = PresenterVocabulary()
    
    let btnNext: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleNextPage), for:
            .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    let btnPrev: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleNextPage), for:
            .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let postionVocab: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterVocabulary.delegateVocabulary = self as? DelegateVocabulary
        setupProgress()
        setupUI()
    }
    
    func setupProgress(){
        progressPercent.maximumValue = Float(presenterVocabulary.numberOfVocab ?? 0)
        progressPercent.setProgress(Float(postionVocab), animated: true)
    }
    
    func getNameLesson(nameLesson: String){
        self.navigationItem.title = "\(nameLesson)"
    }
    
    func setupUI(){
        //register
        collectionVocab.register(UINib(nibName: "VocabularyCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyCell")
        collectionVocab.isPagingEnabled = true
        collectionVocab.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = presenterVocabulary.numberOfVocab ?? 0
        
        [btnNext, btnPrev, pageControl].forEach {
            view.addSubview($0) }
        
        btnNext.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btnNext.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        btnNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        btnPrev.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btnPrev.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        btnPrev.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pageControl.centerYAnchor.constraint(equalTo: btnNext.centerYAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    var positon:Int?
    
    @objc func handleNextPage(button: UIButton) {
        
        var indexPath: IndexPath!
        var current = pageControl.currentPage
        
        if button.tag == 0 {
            current -= 1
            progressPercent.setProgress(Float(postionVocab + current), animated: true)
            if current < 0 {
                current = 0
                
            }
        } else {
            current += 1
            progressPercent.setProgress(Float(postionVocab + current), animated: true)
            if current == presenterVocabulary.numberOfVocab {
                current = (presenterVocabulary.numberOfVocab ?? 0) - 1
     
            }
        }
        
        indexPath = IndexPath(item: current, section: 0)
        collectionVocab.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenterVocabulary.numberOfVocab ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyCell", for: indexPath) as! VocabularyCell
        
        cell.setDataForVocabularyCell(imageCard: "https://c1.staticflickr.com/9/8112/8477434985_5f637b7d84_z.jpg", japanese: "たまご", vietnamese: "Quả Trứng", listenLink: "null")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
