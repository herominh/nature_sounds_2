//
//  SoundManager.swift
//  nature sound
//
//  Created by admin on 12/1/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import Foundation
import AVFoundation
import Toast_Swift

final class SoundManager {
    let TAG:String = "SoundManager::"
    static let shared = SoundManager()
    
    var listSoundPlaying:[String:PlaySoundItem] = [:]
    var listAudioPlaying:[String:AVAudioPlayer] = [:]
    
    func playSound(object: PlaySoundItem) {
        print("\(TAG) playSound: \(object.sound.name)")
        do {
            let url = Bundle.main.path(forResource: object.sound.soundUri, ofType: "mp3")
            if url != nil {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                let soundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: url!))
                soundEffect.prepareToPlay()
                soundEffect.numberOfLoops = -1
                soundEffect.volume = 1
                soundEffect.play()
                
                listAudioPlaying[object.sound.id] = soundEffect
                listSoundPlaying[object.sound.id] = object
            } else {
                print("\(TAG) url is nil \(object.sound.name)")
            }
        } catch {
            print("\(TAG) \(error)")
        }
    }
    
    func stopSound(id: String) {
        let soundEffect = listAudioPlaying[id]
        if soundEffect != nil && soundEffect!.isPlaying {
            soundEffect?.stop()
            listAudioPlaying.removeValue(forKey: id)
            listSoundPlaying.removeValue(forKey: id)
        }
    }
    
    func stopAllSound() {
        listAudioPlaying.forEach {
            if (($1) as AVAudioPlayer).isPlaying {
                ($1).stop()
            }
        }
        listSoundPlaying.removeAll()
        listAudioPlaying.removeAll()
    }
    
}
