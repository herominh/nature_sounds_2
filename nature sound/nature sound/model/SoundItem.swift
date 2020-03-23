//
//  SoundItem.swift
//  nature sound
//
//  Created by admin on 10/30/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import Foundation
import UIKit

class SoundItem : NSObject{
    var id:String
    var name : String
    var soundUri : String
    var avatarUri: String
    
    init(id:String, name:String, uri:String, avatar:String) {
        self.id = id
        self.name = name
        self.soundUri = uri
        self.avatarUri = avatar
    }
    
    init(dic: NSDictionary) {
        self.id = dic.value(forKey: "id") as! String
        self.name = dic.value(forKey: "name") as! String
        self.soundUri = dic.value(forKey: "soundUri") as! String
        self.avatarUri = dic.value(forKey: "avatarName") as! String
    }
}
