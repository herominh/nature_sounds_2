//
//  AdsChartboost.swift
//  AutoAdsSwift
//
//  Created by minh on 3/25/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation

class AdsChartboost{

    public func start(){
        Chartboost.start(withAppId: adsConfig.chartboost_app_id, appSignature: adsConfig.chartboost_app_signature, delegate: nil)
    }
    
    public func showInterstitial(){
        mLog("")
        Chartboost.showInterstitial(CBLocationDefault)
    }
}

