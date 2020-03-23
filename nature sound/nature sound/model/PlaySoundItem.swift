//
//  PlaySoundItem.swift
//  nature sound
//
//  Created by admin on 11/7/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import Foundation

class PlaySoundItem : NSObject{
    private var DEFAULT_VOLUME = 1
    
    var sound:SoundItem
    var volume:Int
    var isPlaying = false
    
    init(_sound : SoundItem, volume:Int) {
        self.sound = _sound
        self.volume = volume
    }
    
    init(_sound : SoundItem) {
        self.sound = _sound
        self.volume = DEFAULT_VOLUME
    }
    
}
