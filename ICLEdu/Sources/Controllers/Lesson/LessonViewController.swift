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
        
        collectionViewSetUp()
    }
    
    func collectionViewSetUp(){
        lessonCollectionView.delegate = self
        lessonCollectionView.dataSource = self
        
        //registerNavNib
        let navCell = UINib(nibName: "NavCell", bundle: nil)
        lessonCollectionView.register(navCell, forCellWithReuseIdentifier: "NavCell")
        //registerHeaderLessonNib
        let headerLessonCell = UINib(nibName: "HeaderLessonCell", bundle: nil)
        lessonCollectionView.register(headerLessonCell, forCellWithReuseIdentifier: "HeaderLessonCell")
        //registerLessonNib
        let lessonCell = UINib(nibName: "LessonCell", bundle: nil)
        lessonCollectionView.register(lessonCell, forCellWithReuseIdentifier: "LessonCell")
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
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let navCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavCell", for: indexPath) as! NavCell
            navCell.parseDataForNav(userName: profileData?.name ?? "", userImageUrl: profileData?.avatar ?? "")
            return navCell
        }
        if indexPath.row == 1 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderLessonCell", for: indexPath) as! HeaderLessonCell
            headerCell.parseDataLessonCell(img: "https://www.petmd.com/sites/default/files/petmd-cat-snoring.jpg")
            return headerCell
        }
        
        let lessonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonCell", for: indexPath) as! LessonCell
        lessonCell.parseDataLessonCell(img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROQaP3Ur0SxuyCQ-y3AK6TBmesaRvp160YZdJl-C0lTa4rXvTu", name: "Lesson \(indexPath.row)", num: "Bài \(indexPath.row)")
        return lessonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            let widthHeader = collectionView.frame.size.width
            return CGSize(width: widthHeader, height: 66)
        }
        if indexPath.row == 1{
            let widthHeader = collectionView.frame.size.width
            return CGSize(width: widthHeader, height: 200)
        }
        let width = (collectionView.frame.size.width - 10) / 2
        return CGSize.init(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let profileVC = UIStoryboard.init(name: "ProfileController", bundle: nil).instantiateViewController(withIdentifier: "ProfileController") as? ProfileViewController
//            self.navigationController?.pushViewController(profileVC!, animated: true)
//            let profileVC = ProfileViewController()
//            profileVC?.modalTransitionStyle = .coverVertical
//            self.present(profileVC!, animated: true, completion: nil)
//            self.navigationController?.pushViewController(profileVC!, animated: true)
//        }
//        if indexPath.row == 1  {
//            print("banner")
//        }
        if indexPath.row != 0 && indexPath.row != 1 {
            let vocabularyVC = UIStoryboard.init(name: "VocabularyController", bundle: nil).instantiateViewController(withIdentifier: "VocabularyController") as? VocabularyViewController
            vocabularyVC?.getNameLesson(nameLesson: "Bài \(indexPath.row)")
            vocabularyVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vocabularyVC!, animated: true)
        }
    }
}
