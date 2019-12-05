//
//  ButtonVocabCell.swift
//  ILCEdu
//
//  Created by Tuan Ta on 12/4/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class ButtonVocabCell: UITableViewCell {
    
    @IBOutlet weak var listenButton: UIButton!
    private var player : AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listenButton.rx.tap.bind { _ in
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            self.player!.seek(to: CMTime.zero)
            self.player!.play()
        }
    }
    
    func playerInit(_ linkAudio:String) {
        let url = URL(string: baseUrlMedia + (linkAudio))
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
