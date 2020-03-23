//
//  SoundCell.swift
//  nature sound
//
//  Created by admin on 10/29/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class SoundCell: UICollectionViewCell {
    
    let TAG:String = "SoundCell"
    var image: UIImageView = UIImageView()
    
    var img: UIImage!
    var isPlaying = false
    var object:PlaySoundItem!
    var userInfo:[String:PlaySoundItem] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(image)
        image.snp.makeConstraints{(make) -> Void in
            make.top.left.right.bottom.equalToSuperview().inset(15)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSoundClose(_:)), name: Notification.Name.closeSound, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    @objc func onSoundClose(_ notification: Notification) {
        guard let soundId = notification.userInfo?["id"] as? String else { return }
        
        if object.sound.id == soundId {
            print("\(TAG) on notification close a sound \(object.sound.name)")
            isPlaying = false
            updateView()
        }
    }
    
    func setImage(sound: PlaySoundItem, color: String) {
        object = sound
        userInfo.updateValue(object, forKey: "sound")
        img = UIImage(named: sound.sound.avatarUri)
        image.image = img
        image.alpha = 0.4
        image.contentScaleFactor = 0.8
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        image.isUserInteractionEnabled = true
        
        let theme = UIColor(hex : color)
        //image.image = image.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        image.tintImageColor(color: theme)
    
    }

    private func updateView () {
        if !isPlaying {
            image.alpha = 0.4
            image.snp.updateConstraints{(make) -> Void in
                make.top.left.right.bottom.equalToSuperview().inset(15)
            }
        } else {
            image.alpha = 1
            image.snp.updateConstraints{(make) -> Void in
                make.top.left.right.bottom.equalToSuperview().inset(5)
            }
        }
    }
    
    @objc func imageTapped()
    {
        if !isPlaying && SoundManager.shared.listSoundPlaying.count == 4 {
            NotificationCenter.default.post(name: .maxSound, object: nil, userInfo: nil)
            return
        }
        
        isPlaying = !isPlaying
        updateView()
        object.isPlaying = isPlaying
        userInfo.updateValue(object, forKey: "sound")
        NotificationCenter.default.post(name: .playSound, object: nil, userInfo: userInfo)
    }

}


