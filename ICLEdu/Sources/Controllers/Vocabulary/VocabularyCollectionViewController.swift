//
//  VocabularyCollectionViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/27.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class VocabularyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
    
    private let presenterVocabulary = PresenterVocabulary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenterVocabulary.delegateVocabulary = self as? DelegateVocabulary
        UI()
    }
    
    func UI(){
        //register
        collectionView.register(UINib(nibName: "VocabularyCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    @objc func handleNextPage(button: UIButton) {
        
        var indexPath: IndexPath!
        var current = pageControl.currentPage
        
        if button.tag == 0 {
            current -= 1
            if current < 0 {
                current = 0
                presenterVocabulary.positionOfVocab = current
            }
        } else {
            current += 1
            if current == presenterVocabulary.numberOfVocab {
                current = (presenterVocabulary.numberOfVocab ?? 1) - 1
                presenterVocabulary.positionOfVocab = current
            }
        }
        
        indexPath = IndexPath(item: current, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenterVocabulary.numberOfVocab ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
