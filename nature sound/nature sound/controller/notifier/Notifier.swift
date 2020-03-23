//
//  Notifier.swift
//  nature sound
//
//  Created by admin on 11/14/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let soundStateChanged = Notification.Name(rawValue: "soundStateChanged")
    
    static let playSound = Notification.Name(rawValue: "playSound")
    
    static let closeSound = Notification.Name(rawValue: "closeSound")
    
    static let settingSounds = Notification.Name(rawValue: "settingSounds")
    
    static let closeAllSound = Notification.Name(rawValue: "closeAllSound")
    
    static let playSoundCollection = Notification.Name(rawValue:"playSoundCollection")
    
    static let maxSound = Notification.Name(rawValue: "maxSound")
}
