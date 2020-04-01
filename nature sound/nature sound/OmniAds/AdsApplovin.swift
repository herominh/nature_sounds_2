//
//  AdsApplovin.swift
//  AutoAdsSwift
//
//  Created by minh on 3/28/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation
import AppLovinSDK



class AdsApplovin : UIViewController, ALAdLoadDelegate {
    var ad: ALAd?

    func loadInterstitialAd()
    {
        // Load an interstitial ad and be notified when the ad request is finished.
        ALSdk.shared()?.adService.loadNextAd(ALAdSize.interstitial, andNotify: self)
    }
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        // We now have an interstitial ad we can show!
        mLog("")
        self.ad = ad
        ALInterstitialAd.shared().showOver(UIApplication.shared.keyWindow!, andRender: ad)
    }

    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        // Look at ALErrorCodes.h for list of error codes.
        mLog("")
    }

    public func start(){
        mLog("")
        ALSdk.initializeSdk()
    }
    
    public func showInterstitial(){
        mLog("")
        loadInterstitialAd()
    }
}

