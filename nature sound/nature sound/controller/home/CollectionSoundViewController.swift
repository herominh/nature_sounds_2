//
//  CollectionSoundViewController.swift
//  nature sound
//
//  Created by admin on 10/28/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import UIKit

class CollectionSoundViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mCollectionName: UILabel!
    @IBOutlet weak var mBackgroundImg: UIImageView!
    @IBOutlet weak var divider: UIView!
    
    var index = 0
    
    let cellIdentifier = "SoundCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 30.0, bottom: 50.0, right: 30.0)
    fileprivate var itemsPerRow: CGFloat = 3
    
    var mSounds : [PlaySoundItem] = []
    
    @IBOutlet weak var soundsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
            itemsPerRow = 3
        case .pad:
        // It's an iPad
            itemsPerRow = 5
        case .unspecified:
            itemsPerRow = 3
        case .tv:
            itemsPerRow = 5
        case .carPlay:
            itemsPerRow = 5
        }
        
        soundsCollection.dataSource = self
        soundsCollection.delegate = self
        soundsCollection.register(SoundCell.self, forCellWithReuseIdentifier: cellIdentifier)
        loadData()
        updateScreen()
        // Do any additional setup after loading the view.
        
        //let theme = UIColor(red: 120/255, green: 150/255, blue: 200/255, alpha: 1) //
        let theme = UIColor(hex : Singleton.shared.themeColor[self.index])
        mCollectionName.textColor = theme
        divider.backgroundColor = theme
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setIndex(index : Int) {
        self.index = index
        
    }
    
    func addSounds(list : [PlaySoundItem]) {
        mSounds += list
        soundsCollection.reloadData()
    }
    
    func updateScreen() {
        mCollectionName.text = NSLocalizedString(Singleton.shared.nameId[self.index], comment: "")
        let img = UIImage(named: Singleton.shared.background[self.index])
        mBackgroundImg.image = img
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "resource", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
                    switch index {
                    case 0: do {
                        // ---------- rain -----------
                        if let array : [NSDictionary] = jsonResult["rain"] as? [NSDictionary] {
                            let count = array.count
                            for index in 0..<count {
                                let sound : SoundItem = SoundItem(dic : array[index])
                                let playItem = PlaySoundItem(_sound : sound)
                                Singleton.shared.rainSound.append(playItem)
                            }
                            addSounds(list: Singleton.shared.rainSound)
                        }
                    }
                        
                    case 1: do {
                        // ---------- nature -----------
                        if let array : [NSDictionary] = jsonResult["nature"] as? [NSDictionary] {
                            let count = array.count
                            for index in 0..<count {
                                let sound : SoundItem = SoundItem(dic : array[index])
                                let playItem = PlaySoundItem(_sound : sound)
                                Singleton.shared.forestSound.append(playItem)
                            }
                            addSounds(list: Singleton.shared.forestSound)
                        }
                    }
                        
                    case 2: do {
                        // ---------- farm -----------
                        if let array : [NSDictionary] = jsonResult["farm"] as? [NSDictionary] {
                            let count = array.count
                            for index in 0..<count {
                                let sound : SoundItem = SoundItem(dic : array[index])
                                let playItem = PlaySoundItem(_sound : sound)
                                Singleton.shared.farmSound.append(playItem)
                            }
                            addSounds(list: Singleton.shared.farmSound)
                        }
                    }
                        
                    case 3: do {
                        // ---------- city -----------
                        if let array : [NSDictionary] = jsonResult["city"] as? [NSDictionary] {
                            let count = array.count
                            for index in 0..<count {
                                let sound : SoundItem = SoundItem(dic : array[index])
                                let playItem = PlaySoundItem(_sound : sound)
                                Singleton.shared.citySound.append(playItem)
                            }
                            addSounds(list: Singleton.shared.citySound)
                        }
                    }
                        
                    case 4: do {
                        // ---------- relax -----------
                        if let array : [NSDictionary] = jsonResult["relax"] as? [NSDictionary] {
                            let count = array.count
                            for index in 0..<count {
                                let sound : SoundItem = SoundItem(dic : array[index])
                                let playItem = PlaySoundItem(_sound : sound)
                                Singleton.shared.relaxSound.append(playItem)
                            }
                            addSounds(list: Singleton.shared.relaxSound)
                        }
                    }
                        
                    default: do {
                        print("nothing in index")
                    }
                    
                    }
                } catch {
                    print("JSON is invalid")}
            } catch {
                print("no file")
            }
        } else {
            print("somethings till wrong")
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mSounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifier, for: indexPath) as! SoundCell
        cell.setImage(sound: mSounds[indexPath.row], color: Singleton.shared.themeColor[self.index])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow - 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
