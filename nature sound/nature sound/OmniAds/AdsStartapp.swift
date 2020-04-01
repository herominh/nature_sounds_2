//
//  AdsTappx.swift
//  AutoAdsSwift
//
//  Created by minh on 3/30/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation

class AdsStartapp: UIViewController, STADelegateProtocol {
    lazy var startAppAdAutoLoad = STAStartAppAd()

    public func start(){
        mLog("");
        guard let sdk = STAStartAppSDK.sharedInstance() else {
            fatalError("StartAppSDK initialization failed!")
        }

        if sdk.appID == nil {
            mLog("")
            sdk.appID = adsConfig.startapp_app_id
            sdk.disableReturnAd()
        }
        startAppAdAutoLoad!.load()

    }

    public func showInterstital(){
        mLog("")
        startAppAdAutoLoad!.show()
    }
    
    // StartApp Ad loaded successfully
    func didLoad(_ ad: STAAbstractAd) {
        mLog("")

    }
    
    // StartApp Ad failed to load
    func failedLoad(_ ad: STAAbstractAd, withError error: Error) {
        mLog("")
    }
    
    // StartApp Ad is being displayed
    func didShow(_ ad: STAAbstractAd) {
        mLog("")
    }
    
    // StartApp Ad failed to display
    func failedShow(_ ad: STAAbstractAd, withError error: Error) {
        mLog("")
    }
    
    // StartApp Ad is being displayed
    func didClose(_ ad: STAAbstractAd) {
        mLog("")
    }
    
    // StartApp Ad is being displayed
    func didClick(_ ad: STAAbstractAd) {
        mLog("")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        mLog("")
    }
    


}
