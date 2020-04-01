//
//  AdsVungle.swift
//  AutoAdsSwift
//
//  Created by minh on 3/25/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation
import UIKit

class AdsVungle: UIViewController, VungleSDKDelegate{
    var sdk:VungleSDK?
    var viewController:UIViewController?

    public func start(){
        sdk = VungleSDK.shared()
        sdk?.delegate = self
        do {
            mLog("");
            try sdk?.start(withAppId: adsConfig.vungle_app_id);
        }
        catch let error as NSError {
            mLog("");
            print("Error while starting VungleSDK : \(error.domain)")
            return;
        }

    }
    
    public func showInterstitial(_ viewController: UIViewController){
        mLog("");
        self.viewController = viewController
        do {
            try sdk?.loadPlacement(withID: adsConfig.vungle_placement_id)
        }
        catch let error as NSError {
            print("Unable to load placement with reference ID :\("DEFAULT-1329351"), Error: \(error)")
             
            return
        }
        
    }
    
    func vungleAdPlayabilityUpdate(_ isAdPlayable: Bool, placementID: String?) {
        if (true == isAdPlayable && placementID == adsConfig.vungle_placement_id)
        {
            if let viewController = self.viewController{
                do {
                    try sdk?.playAd(viewController, options:nil, placementID: adsConfig.vungle_placement_id)
                    
                }
                catch let error as NSError {
                    mLog("");

                 print("Error encountered playing ad: + \(error)");
                }
            }
        }
    }
}

