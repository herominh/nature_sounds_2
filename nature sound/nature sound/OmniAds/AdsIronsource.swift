//
//  AdsIronsource.swift
//  AutoAdsSwift
//
//  Created by minh on 3/30/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation

class AdsIronsource : UIViewController, ISInterstitialDelegate {
    private var viewController: UIViewController?
    public func start(){
        mLog("");
        IronSource.setInterstitialDelegate(self)
        IronSource.initWithAppKey(adsConfig.ironsource_app_key, adUnits:[IS_INTERSTITIAL])
        //ISIntegrationHelper.validateIntegration()
    }
    
    public func showInterstital(_ viewController: UIViewController){
        mLog("")
        self.viewController = viewController
        //ISIntegrationHelper.validateIntegration()

        IronSource.loadInterstitial()
    }
    
    func interstitialDidLoad() {
        mLog("")
        if(IronSource.hasInterstitial()){
            IronSource.showInterstitial(with: self.viewController!)
        }
    }
    
    func interstitialDidFailToLoadWithError(_ error: Error!) {
        mLog("")
    }
    
    func interstitialDidOpen() {
        mLog("")
    }
    
    func interstitialDidClose() {
        mLog("")
    }
    
    func interstitialDidShow() {
        mLog("")
    }
    
    func interstitialDidFailToShowWithError(_ error: Error!) {
        mLog("")
    }
    
    func didClickInterstitial() {
        mLog("")
    }
    

}
