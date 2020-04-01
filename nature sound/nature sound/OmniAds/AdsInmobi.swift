//
//  AdsInmobi.swift
//  AutoAdsSwift
//
//  Created by minh on 3/29/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation
import InMobiSDK.IMSdk
import InMobiSDK.IMInterstitial
import InMobiSDK.IMInterstitialDelegate


class AdsInmobi : UIViewController, IMInterstitialDelegate {
    var interstitial: IMInterstitial?
    var viewController: UIViewController?

    public func start(){
        mLog("")
        let conscentDict: NSDictionary = [IM_GDPR_CONSENT_AVAILABLE : "true"]
        IMSdk.initWithAccountID(adsConfig.inmobi_account_id, consentDictionary:conscentDict as? [AnyHashable : Any])
        /*
        * Enable logging for better debuggability. Please turn off the logs before submitting your App to the AppStore
        */
        //IMSdk.setLogLevel(IMSDKLogLevel.debug)
        
    }
       
    public func interstitialDidFinishLoading(_ interstitial: IMInterstitial!) {
        mLog("")
        interstitial?.show(from: self.viewController)

    }
    
    public func showInterstitial(_ viewController: UIViewController){
        mLog("")
        self.viewController = viewController
        interstitial = IMInterstitial.init(placementId: adsConfig.inmobi_interstitial_placement)
        interstitial?.delegate = self
        interstitial?.load()
    }
    
    public func interstitialDidReceiveAd(_ interstitial: IMInterstitial!) {
        NSLog("[ViewController %@]", #function)
    }
    
    /**
     * Notifies the delegate that the interstitial has failed to load with some error.
     */
    public func interstitial(_ interstitial: IMInterstitial!, didFailToLoadWithError error: IMRequestStatus!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
        NSLog("Interstitial ad failed to load with error %@", error)
    }
    /**
     * Notifies the delegate that the interstitial would be presented.
     */
    public func interstitialWillPresent(_ interstitial: IMInterstitial!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the interstitial has been presented.
     */
    public func interstitialDidPresent(_ interstitial: IMInterstitial!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the interstitial has failed to present with some error.
     */
    public func interstitial(_ interstitial: IMInterstitial!, didFailToPresentWithError error: IMRequestStatus!) {
        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the interstitial will be dismissed.
     */
    public func interstitialWillDismiss(_ interstitial: IMInterstitial!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the interstitial has been dismissed.
     */
    public func interstitialDidDismiss(_ interstitial: IMInterstitial!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the interstitial has been interacted with.
     */
    public func interstitial(_ interstitial: IMInterstitial!, didInteractWithParams params: [AnyHashable : Any]!) {
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    /**
     * Notifies the delegate that the user will leave application context.
     */
    public func userWillLeaveApplication(from interstitial: IMInterstitial!){
        mLog("")

        NSLog("[ViewController %@]", #function)
    }
    
    
}


