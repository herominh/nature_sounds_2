//
//  CommonStyle.swift
//  nature sound
//
//  Created by admin on 11/24/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import Foundation
import UIKit

struct CommonStyle {
    static let RoundedButtonStyle: UIViewStyle<UIButton> = UIViewStyle { button in
        button.backgroundColor = MyColors.ColorPrimary
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    static let RectangleButtonStyle: UIViewStyle<UIButton> = UIViewStyle { button in
        button.backgroundColor = MyColors.ColorPrimary
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

}

struct TextButtonStyles {
    static let ControlButton: UIViewStyle<UIButton> = UIViewStyle { btn in
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
