//
//  QuestionCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/25/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    var qImageLink:String?
    var qAudioLink:String?
    var qLabel:String?
    var qSuggest:String?
    var arrayAnswer:[String] = ["AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", "CCCCCCCCCCCCCCCC", "DDDDDD"]
    var clicked:Bool = false
    var typeQuestion = 2
    func setQuestionData(qImage:String?, qAudio:String?, qLabel:String?, qSuggest:String?) {
        self.qImageLink = qImage
        self.qAudioLink = qAudio
        self.qLabel = qLabel
        self.qSuggest = qSuggest
        //
        if qImage != "" {
            
        }else if qAudio != "" {
            
        }else if qLabel != "" {
            
        }
    }
    
    @IBOutlet weak var questionTableView: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionTableView.delegate = self
        questionTableView.dataSource = self
        //
        questionTableView.register(UINib(nibName: textQuestionCell, bundle: nil), forCellReuseIdentifier: textQuestionCell)
        //
        questionTableView.register(UINib(nibName: audioQuestionCell, bundle: nil), forCellReuseIdentifier: audioQuestionCell)
        //
        questionTableView.register(UINib(nibName: imageQuestionCell, bundle: nil), forCellReuseIdentifier: imageQuestionCell)
        //
        questionTableView.register(UINib(nibName: suggestCell, bundle: nil), forCellReuseIdentifier: suggestCell)
        //
        questionTableView.register(UINib(nibName: answerCell, bundle: nil), forCellReuseIdentifier: answerCell)
        //
        questionTableView.estimatedRowHeight = 75
    }
}

extension QuestionCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + arrayAnswer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if typeQuestion == 1{
                let textQuest = tableView.dequeueReusableCell(withIdentifier: textQuestionCell) as! TextQuestionCell
                textQuest.isUserInteractionEnabled = false
                textQuest.textQuestionLabel.text = "hfjkasdfjkasjkdfhhjsdfjlkaslkdflasdfhjadfkjsdfhsakjfdhaksjfhkasfdhsdfjkasfksdfhksjfdhkasfhklasdlkf"
                return textQuest
            }else if typeQuestion == 2{
                let audioQuest = tableView.dequeueReusableCell(withIdentifier: audioQuestionCell) as! AudioQuestionCell
                audioQuest.isUserInteractionEnabled = false
                return audioQuest
            }else if typeQuestion == 3{
                let imageQuest = tableView.dequeueReusableCell(withIdentifier: imageQuestionCell) as! ImageQuestionCell
                imageQuest.isUserInteractionEnabled = false
                return imageQuest
            }
        }
        
        if indexPath.row == 1 {
            let suggest = tableView.dequeueReusableCell(withIdentifier: suggestCell) as! SuggestCell
            suggest.suggestLabel.text = "hfjkasdfjkasjkdfhhjsdfjlkaslkdflasdfhjadfkjsdfhsakjfdhaksjfhkasfdhsdfjkasfksdfhksjfdhkasfhklasdlkfhfjkasdfjkasjkdfhhjsdfjlkaslkdflasdfhjadfkjsdfhsakjfdhaksjfhkasfdhsdfjkasfksdfhksjfdhkasfhklasdlkfhfjkasdfjkasjkdfhhjsdfjlkaslkdflasdfhjadfkjsdfhsakjfdhaksjfhkasfdhsdfjkasfksdfhksjfdhkasfhklasdlkf"
            suggest.isUserInteractionEnabled = false
            return suggest
        }
        
        let answer = tableView.dequeueReusableCell(withIdentifier: answerCell) as! AnswerCell
        answer.answerLabel.text = arrayAnswer[(indexPath.row - 2)]
        return answer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click in \(indexPath.row)")
        let cell = tableView.cellForRow(at: indexPath) as! AnswerCell
        //        cell.checkChose(position: indexPath.row)
        
        if indexPath.row == 2 {
            cell.choseStatus.backgroundColor = .colorGreen
            if indexPath.row != 2 {
                cell.choseStatus.backgroundColor = .white
            }
        }
        
        if indexPath.row == 3 {
            cell.choseStatus.backgroundColor = .colorGreen
            if indexPath.row != 3 {
                cell.choseStatus.backgroundColor = .white
            }
            
        }
        
        if indexPath.row == 4 {
            cell.choseStatus.backgroundColor = .colorGreen
            if indexPath.row != 4 {
                cell.choseStatus.backgroundColor = .white
            }
            
        }
        
        if indexPath.row == 5 {
            cell.choseStatus.backgroundColor = .colorGreen
            if indexPath.row != 5 {
                cell.choseStatus.backgroundColor = .white
            }
            
        }
    }
    
}

