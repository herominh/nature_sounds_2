//
//  FavoritesViewController.swift
//  nature sound
//
//  Created by admin on 10/28/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mFavoriteList: UITableView!
    
    var soundCollection : [PlaySoundItem] = []
    
    let identifier = "FavoriteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mFavoriteList.delegate = self
        mFavoriteList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func addSounds(list : [PlaySoundItem]) {
        soundCollection += list
        mFavoriteList.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! FavoriteCell
        
        if soundCollection.count > 0 {
            cell.soundName.text = soundCollection[indexPath.row].sound.name
            let image : UIImage = UIImage(named: soundCollection[indexPath.row].sound.avatarUri)!
            cell.imgBackgound.image = image
            cell.setSound(sound: soundCollection[indexPath.row])
        }
        
        return cell
    }
    

}
