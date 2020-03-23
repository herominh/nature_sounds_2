//
//  SoundsSettingController.swift
//  nature sound
//
//  Created by admin on 11/28/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import UIKit
import SnapKit

protocol SoundControlListener {
    func onCloseSound(sound: PlaySoundItem)
}

class SoundsSettingController: UIViewController, SoundControlListener {

    @IBOutlet weak var listSound: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listSound.dataSource = self
        listSound.delegate = self
        listSound.separatorStyle = .none
        listSound.alwaysBounceVertical = false
        listSound.register(UINib(nibName: "SoundSettingItemCell", bundle: nil),
        forCellReuseIdentifier: "ItemCell")
    }
    
    func onCloseSound(sound: PlaySoundItem) {
//        SoundManager.shared.stopSound(id: sound.sound.id)
        sound.isPlaying = false
        let soundId:[String:String] = ["id": sound.sound.id]
        let soundInfo:[String: PlaySoundItem] = ["sound": sound]
        NotificationCenter.default.post(name: .closeSound, object: nil, userInfo: soundId)
        NotificationCenter.default.post(name: .playSound, object: nil, userInfo: soundInfo)
        
        if SoundManager.shared.listSoundPlaying.count == 0 {
            // must dismis setting dialog
            listSound.reloadData()
        } else {
            listSound.reloadData()
        }
        
    }
       
}

extension SoundsSettingController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SoundManager.shared.listSoundPlaying.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
                as? SoundSettingItemCell else {
            return UITableViewCell()
        }
        let sound = Array(SoundManager.shared.listSoundPlaying)[indexPath.row].value
        cell.updateCell(sound: sound, _listener: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}
