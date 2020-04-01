//
//  AdsTapjoy.swift
//  AutoAdsSwift
//
//  Created by minh on 3/29/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation

class AdsTapjoy: UIViewController, TJPlacementDelegate{
    private var viewController: UIViewController?
    public func start(){
        mLog("")
        Tapjoy.setDebugEnabled(true)
        Tapjoy.setUserConsent("0")
        Tapjoy.connect(adsConfig.tapjoy_sdk_key)
    }
    
    public func showInterstitial(_ viewController: UIViewController){
        mLog("")
        //let p = TJPlacement()
        self.viewController = viewController
        if let id = TJPlacement.placement(withName: adsConfig.tapjoy_placement_name, delegate: self){
            mLog("")
            (id as AnyObject).requestContent()
        } else{
            mLog("")
        }
}
    
    func requestDidSucceed(_ placement: TJPlacement?) {
        mLog("")
        if let placementUnwrap = placement{
            placementUnwrap.showContent(with: self.viewController)
        }
    }
    
    func requestDidFail(_ placement: TJPlacement?, error: Error?) {
        mLog("")
    }
    
    func tjcConnectSuccess(){
        mLog("")
    }
    
}
