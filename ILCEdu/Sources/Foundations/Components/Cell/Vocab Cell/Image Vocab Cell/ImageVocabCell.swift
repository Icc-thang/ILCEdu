//
//  ImageVocabCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/3/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class ImageVocabCell: UITableViewCell {
    
    @IBOutlet weak var vocabImageView: UIImageView!
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var hiraLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDataForImageVocabCell(imageUrl:String?, japanese:String?, kanji:String?, example:String?) {
        
        vocabImageView.sd_setImage(with: URL(string: baseUrlMedia + (imageUrl ?? "")))
        
        vocabImageView.CardImage()
        
        hiraLabel.text = japanese ?? ""
        
        kanjiLabel.text = kanji ?? ""
        
        exampleLabel.text = example ?? ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        UIView.transition(from: view, to: vocabImageView, duration: 0, options: [.showHideTransitionViews] , completion: nil)
    }
    
    func flip(){
        UIView.transition(from: vocabImageView, to: view, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
    
    func flipBack(){
        UIView.transition(from: view, to: vocabImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
}
