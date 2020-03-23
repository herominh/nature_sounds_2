//
//  Singleton.swift
//  nature sound
//
//  Created by admin on 11/7/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import Foundation

final class Singleton {
    static let shared = Singleton()
    
    private init() {
        
    }
    
    var favoriteSound : [PlaySoundItem] = []
    var rainSound : [PlaySoundItem] = []
    var forestSound : [PlaySoundItem] = []
    var farmSound : [PlaySoundItem] = []
    var citySound : [PlaySoundItem] = []
    var relaxSound : [PlaySoundItem] = []
    
    var nameId = ["rain_water", "nature_forest", "farm", "city", "relax"]
    var name = ["Rain & Water", "Nature & Forest", "Farm", "City", "Relax"]
    var background = ["bg_rain", "bg_forest", "bg_farm", "bg_city", "bg_relax"]
    var themeColor = ["03A9F4", "4CAF50", "6D4C41", "FF9800", "009688"]
    
    var numberSoundPlaying = 0
}
