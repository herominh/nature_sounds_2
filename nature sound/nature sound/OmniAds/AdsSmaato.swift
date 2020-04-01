//
//  AdsSmaato.swift
//  AutoAdsSwift
//
//  Created by minh on 3/29/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation
import SmaatoSDKCore
import SmaatoSDKInterstitial


class AdsSmaato : UIViewController, SMAInterstitialDelegate{
    //private var interstitial: SMAInterstitial?
    private var viewController: UIViewController?

    func interstitialDidLoad(_ interstitial: SMAInterstitial) {
        //self.interstitial = interstitial
        mLog("")
        interstitial.show(from: self.viewController!)
        
    }
    
    func interstitial(_ interstitial: SMAInterstitial?, didFailWithError error: Error) {
        mLog("")
        print("minh: Interstitial did fail loading with error: \(error.localizedDescription)")

    }
    
    func interstitialDidTTLExpire(_ interstitial: SMAInterstitial) {
        mLog("")
    }
    
    public func start(){
        mLog("")
        guard let config = SMAConfiguration(publisherId: adsConfig.smaato_publisher_id) else {
            mLog("")

             fatalError("SDK config is nil!")
        }
        config.httpsOnly = false     // allow HTTPS traffic only
        config.logLevel = .error    // log errors only
        config.maxAdContentRating = .undefined  // ads content restriction based on age

        SmaatoSDK.initSDK(withConfig:config)
        SmaatoSDK.gpsEnabled = false // allow the Smaato SDK to automatically get the user's location and put it inside the ad request
        
    }
    
    public func showInterstitial(_ viewController: UIViewController){
        mLog("")

        self.viewController = viewController
        SmaatoSDK.loadInterstitial(forAdSpaceId: adsConfig.smaato_adspace_id,
                                       delegate: self)
    }
}
