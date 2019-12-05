//
//  AudioQuestionCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 11/26/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class AudioQuestionCell: UITableViewCell {
    var player : AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func playAudioQuestion(_ sender: Any) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        player!.seek(to: CMTime.zero)
        player!.play()
    }
    
    func playerInit(_ linkAudio:String) {
        let url = URL(string: baseUrlMedia + ("assets/images/vocabs/audio/ae0581fa7279461fee075a4bfeb39644.mp3"))
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
}
