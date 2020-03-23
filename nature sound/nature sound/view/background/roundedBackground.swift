//
//  roundedBackground.swift
//  nature sound
//
//  Created by admin on 11/18/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import Foundation
import UIKit

class RoundedBackground: UIView {
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
    
}
