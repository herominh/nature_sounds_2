//
//  ControllView.swift
//  nature sound
//
//  Created by admin on 11/16/17.
//  Copyright © 2017 com.digimon. All rights reserved.
//

import UIKit

class ControllView: UIView {

    let TAG: String = "ControllView"
    
    @IBOutlet var mView: UIView!
    @IBOutlet weak var counter: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ControllView", owner: self, options: nil)
        addSubview(mView)
        mView.frame = self.bounds
        mView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mView.translatesAutoresizingMaskIntoConstraints = true

    }
    
    @IBAction func onOpenSetting(_ sender: Any) {
        NotificationCenter.default.post(name: .settingSounds, object: nil)
    }
    
    @IBAction func onClose(_ sender: Any) {
        print("\(TAG) onClose")
        NotificationCenter.default.post(name: .closeAllSound, object: nil)
    }
    
    public func updateCount(count:Int) {
        counter.text = count.description
    }
}
