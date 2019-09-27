//
//  VocabularyCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/25.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class VocabularyCell: UICollectionViewCell {
    
    @IBOutlet weak var cardCollection: UICollectionView!
    
    var vietnameseVocabulary:String?
    
    var isOpen:Bool = false
    
    var imageCardCell:String?
    
    var japaneseCardCell:String?
    
    @IBOutlet weak var vietnameseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardCollection.delegate = self
        cardCollection.dataSource = self
        //register
        cardCollection.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
    }
    
    @IBAction func listenJapanese(_ sender: Any) {
        
    }
    
    @IBAction func showVietnamese(_ sender: Any) {
        vietnameseLabel.text = vietnameseVocabulary ?? "Không có dữ liệu tiếng Việt 🙇‍♂️"
    }
    
    func setDataForVocabularyCell(imageCard:String?, japanese:String?, vietnamese:String?, listenLink:String?){
        imageCardCell = imageCard ?? "không có dữ liệu hình ảnh 🙇‍♂️"
        japaneseCardCell = japanese ?? "Không có dữ liệu tiếng Nhật 🙇‍♂️"
        vietnameseVocabulary = vietnamese ?? "Không có dữ liệu tiếng Việt 🙇‍♂️"
        cardCollection.reloadData()
    }
}
extension VocabularyCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cardCell.setDataForCardCell(imageUrl: imageCardCell ?? "Không có dữ liệu hình ảnh 🙇‍♂️" , japanese: japaneseCardCell ?? "Không có dữ liệu tiếng Nhật 🙇‍♂️")
        return cardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        if isOpen == false{
            cell.flip()
            isOpen = true
        }else if isOpen == true{
            cell.flipBack()
            isOpen = false
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardCollection.frame.width, height: cardCollection.frame.height)
    }
}
