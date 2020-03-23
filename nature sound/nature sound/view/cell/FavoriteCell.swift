//
//  FavoriteCell.swift
//  nature sound
//
//  Created by admin on 10/29/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var soundName: UILabel!
    @IBOutlet weak var imgBackgound: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var object:PlaySoundItem!
    var userInfo:[String:Any] = [:]
    
    var  isPlaying = false
    let playImg = UIImage(named: "ic_play_x")
    let pauseImg = UIImage(named: "ic_pause_x")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPlay(_:)), name: Notification.Name.playSoundCollection, object: nil)
    }
    
    func setSound(sound:PlaySoundItem) {
        self.object = sound
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onPlay(_ notification: Notification) {
        guard let soundId = notification.userInfo?["id"] as? String else { return }
        
        if object.sound.id != soundId && isPlaying{
            print("received noti")
            isPlaying = false
            updateView()
        }
        
    }
    
    @IBAction func onVolumeChange(_ sender: Any) {
    }
    
    @IBAction func onPlayClick(_ sender: Any) {
        isPlaying = !isPlaying
        updateView()
        
    }
    
    func updateView() {
        if isPlaying {
            playBtn.setImage(pauseImg, for: .normal)
            slider.isHidden = false
            
            userInfo.updateValue(object.sound.id, forKey: "id")
            NotificationCenter.default.post(name: .playSoundCollection, object: nil, userInfo: userInfo)
        } else {
            playBtn.setImage(playImg, for: .normal)
            slider.isHidden = true
        }

    }
}
