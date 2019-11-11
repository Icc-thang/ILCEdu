//
//  VCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/11/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class VCell: UICollectionViewCell {
    
    @IBOutlet weak var cardCollection: UICollectionView!
    
    var isOpen:Bool = false
    
    var checkViClick:Bool = false
    
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
        //register
        cardCollection.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layoutIfNeeded()
        self.vietnamVocab.isHidden = true
    }
    
    func setDataForVocabularyCell(imageCard:String?, japanese:String?, kanji:String?, example:String?, vietnamVocab:String?, audioLink:String?){
        self.imageCardCell = imageCard ?? ""
        self.japaneseCardCell = japanese ?? ""
        self.kanjiVocab = kanji ?? ""
        self.exampleVocab = example ?? ""
        self.vietnamVocab.text = vietnamVocab ?? ""
        playerInit(baseUrlMedia + (audioLink ?? ""))
        cardCollection.reloadData()
    }
    
    @IBAction func vietnameseShow(_ sender: Any) {
        if checkViClick == false{
            vietnamVocab.isHidden = false
            checkViClick = true
        }else{
            vietnamVocab.isHidden = true
            checkViClick = false
        }
    }
    
    @IBAction func audioListen(_ sender: Any) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        player!.seek(to: CMTime.zero)
        player!.play()
    }
    
    func playerInit(_ linkAudio:String) {
        let url = URL(string: linkAudio)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    
}

extension VCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cardCell.setDataForCardCell(imageUrl: imageCardCell ?? "" , japanese: japaneseCardCell ?? "", kanji: kanjiVocab, example: exampleVocab)
        return cardCell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        if isOpen == false{
            cell.flip()
            isOpen = true
        }else if isOpen == true{
            cell.flipBack()
            isOpen = false
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
//        return CGSize(width: width, height: width)
//    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
