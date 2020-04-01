//
//  adcolony.swift
//  AutoAdsSwift
//
//  Created by minh on 3/25/20.
//  Copyright © 2020 spec. All rights reserved.
//


import Foundation
import UIKit
import AdColony

class AdsAdcolony : UIViewController, AdColonyInterstitialDelegate{

    public func start(){
        mLog("");
        AdColony.configure(withAppID: adsConfig.adcolony_app_id, zoneIDs: [adsConfig.adcolony_interstitial_zone], options: nil) { (zones) in
            mLog("")
        }
    }
    
    public func showInterstital(){
        mLog("")
        AdColony.requestInterstitial(inZone: adsConfig.adcolony_interstitial_zone, options: nil, andDelegate: self)
    }
    
    func adColonyInterstitialDidLoad(_ interstitial: AdColonyInterstitial)
    {
        if(!interstitial.expired)
        {
            mLog("")
            interstitial.show(withPresenting: self)
        }
        mLog("")
    }
    
    func adColonyInterstitialDidFail(toLoad error: AdColonyAdRequestError)
    {
        mLog("")
        print(error)
    }
    
}

