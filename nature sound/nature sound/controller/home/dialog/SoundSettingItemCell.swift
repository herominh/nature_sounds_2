//
//  SoundSettingItemCell.swift
//  nature sound
//
//  Created by admin on 11/29/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import UIKit
import AVFoundation

class SoundSettingItemCell: UITableViewCell {
    let TAG: String = "SoundSettingItemCell"

    @IBOutlet weak var volumeController: UISlider!
    @IBOutlet weak var soundImageView: UIImageView!
    
    var listenner:SoundControlListener?
    
    var soundObj:PlaySoundItem!
    var audioObj:AVAudioPlayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        volumeController.minimumValue = 0
        volumeController.maximumValue = 1
        volumeController.value = 1
    }
    
    func updateCell(sound: PlaySoundItem, _listener:SoundControlListener) {
        self.soundObj = sound
        self.listenner = _listener
        guard let _id = soundObj?.sound.id else {
            return
        }
        audioObj = SoundManager.shared.listAudioPlaying[_id]
        updateView()
    }
    
    func updateView() {
        let img = UIImage(named: soundObj!.sound.avatarUri)
        soundImageView.image = img
        volumeController.value = audioObj.volume
    }
    
    @IBAction func onVolumeChanged(_ sender: Any) {
        audioObj.volume = volumeController.value
    }
    
    @IBAction func onCloseSound(_ sender: Any) {
        guard let _listener = listenner, let _sound = soundObj else {
            print("\(TAG): oncloseSound, listener or sound nil")
            return
        }
        _listener.onCloseSound(sound: _sound)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
