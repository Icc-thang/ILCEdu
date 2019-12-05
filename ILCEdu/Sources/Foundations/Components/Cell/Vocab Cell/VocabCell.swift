//
//  VocabCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class VocabCell: UICollectionViewCell {
    
    @IBOutlet weak var vocabTableView: UITableView!
    
    fileprivate var imageUrl:String?
    fileprivate var japaneseContent:String?
    fileprivate var kanjiContent:String?
    fileprivate var exampleContent:String?
    fileprivate var meanContent:String?
    fileprivate var linkAudio:String?
    
    fileprivate var isOpen:Bool = false
    fileprivate var statusOfMeaning:Int?
    
    private var model:VocabularyModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vocabTableView.delegate = self
        vocabTableView.dataSource = self
        
        vocabTableView.register(UINib(nibName: imageVocabCell, bundle: nil), forCellReuseIdentifier: imageVocabCell)
        vocabTableView.register(UINib(nibName: meaningVocabCell, bundle: nil), forCellReuseIdentifier: meaningVocabCell)
        vocabTableView.register(UINib(nibName: buttonVocabCell, bundle: nil), forCellReuseIdentifier: buttonVocabCell)
    }
    
    func setModel(_ model: VocabularyModel){
        self.model = model
        vocabTableView.reloadData()
    }
    
//    func setDataForVocabCell(imageUrl:String?, japanese:String?, kanji:String?, example:String?, mean:String?, linkAudio:String?) {
//        self.imageUrl = imageUrl
//        self.japaneseContent = japanese
//        self.kanjiContent = kanji
//        self.exampleContent = example
//        self.meanContent = mean
//        self.linkAudio = linkAudio
//        vocabTableView.reloadData()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isOpen = false
    }
}
extension VocabCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let imgCell = tableView.dequeueReusableCell(withIdentifier: imageVocabCell, for: indexPath) as! ImageVocabCell
            imgCell.setDataForImageVocabCell(imageUrl: model?.vocab_image, japanese:model?.vocab_jp , kanji: model?.vocab_kanji, example: model?.vocab_example)
            imgCell.selectionStyle = .none
            return imgCell
        }
        if indexPath.row == 2 {
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: buttonVocabCell, for: indexPath) as! ButtonVocabCell
            buttonCell.selectionStyle = .none
            buttonCell.playerInit(model?.vocab_audio ?? "")
            return buttonCell
        }
        let meanCell = tableView.dequeueReusableCell(withIdentifier: meaningVocabCell, for: indexPath) as! MeaningVocabCell
        meanCell.selectionStyle = .none
        meanCell.meaningLabel.text = model?.vocab_vi
        return meanCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return tableView.frame.size.width
        }
        if indexPath.row == 2{
            return 86
        }
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imgCell = tableView.cellForRow(at: indexPath) as! ImageVocabCell
            if isOpen == false{
                imgCell.flip()
                isOpen = true
            }else if isOpen == true{
                imgCell.flipBack()
                isOpen = false
            }
        }
    }
}
