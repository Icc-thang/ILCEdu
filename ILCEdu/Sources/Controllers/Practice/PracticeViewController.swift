//
//  PracticeViewController.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/13/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {
    
    @IBOutlet weak var practiceCollectionView: UICollectionView!
     var sectionTitle = ["N5","N4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        registerPraticeCell()
    }
    
    func navigationSetup(){
        let view = NaviView()
        view.setNavigationView(classLabel: tabPractice,
                               userAvatar: UserDefaults.standard.string(forKey: "avatar") ?? avatarBase)
        navigationItem.titleView = view
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func registerPraticeCell(){
        // Register cell classes
        practiceCollectionView.register(UINib(nibName: sectionCell, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionCell)
        practiceCollectionView.register(UINib(nibName: practiceCell, bundle: nil), forCellWithReuseIdentifier: practiceCell)
    }
}

extension PracticeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.size.width, height: 30)
        }
    
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionCell, for: indexPath) as! SectionCell
                cell.sectionTitle.text = sectionTitle[indexPath.section]
                return cell
    
            default:
                assert(false, "Unexpected element kind")
            }
            fatalError()
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: practiceCell, for: indexPath) as! PracticeCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        if indexPath.item % 3 == 0 {
            let cellWidth = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right))
            return CGSize(width: cellWidth, height: 150)
        } else {
            let cellWidth = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right) - flowLayout.minimumInteritemSpacing) / 2
            return CGSize(width: cellWidth, height: 150)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

