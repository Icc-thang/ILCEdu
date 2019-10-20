//
//  VocabularyCell.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/25.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class VocabularyCell: UICollectionViewCell {
    
    @IBOutlet weak var cardCollection: UICollectionView!
    
    var isOpen:Bool = false
    
    var imageCardCell:String?
    
    var kanjiVocab:String?
    
    var exampleVocab:String?
    
    var japaneseCardCell:String?
    
    var vietnam:String?
    
    var audioLink:String?
    
    var player : AVPlayer?
    
    @IBOutlet weak var vietnamVocab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardCollection.delegate = self
        cardCollection.dataSource = self
        //register
        cardCollection.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        vietnamVocab.isHidden = true
    }
    
    func setDataForVocabularyCell(imageCard:String?, japanese:String?, kanji:String?, example:String?, vietnamVocab:String?, audioLink:String?){
        self.imageCardCell = imageCard ?? ""
        self.japaneseCardCell = japanese ?? ""
        self.kanjiVocab = kanji ?? ""
        self.exampleVocab = example ?? ""
        self.vietnamVocab.text = vietnamVocab ?? ""
        playerInit(baseUrlMedia+(audioLink ?? ""))
        cardCollection.reloadData()
    }
    

    
    @IBAction func vietnameseShow(_ sender: Any) {
        vietnamVocab.isHidden = false
    }
    
    @IBAction func audioListen(_ sender: Any) {
        player!.seek(to: CMTime.zero)
        player!.play()
    }
    
    func playerInit(_ linkAudio:String) {
        let url = URL(string: linkAudio)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    
}

extension VocabularyCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cardCell.setDataForCardCell(imageUrl: imageCardCell ?? "" , japanese: japaneseCardCell ?? "", kanji: kanjiVocab, example: exampleVocab)
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
        return CGSize(width: cardCollection.frame.width, height: cardCollection.frame.width)
    }
}
