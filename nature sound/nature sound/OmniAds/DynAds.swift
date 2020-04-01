//
//  DynAds.swift
//  AutoAdsSwift
//
//  Created by minh on 3/26/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation


class DynAds: OmniAds{
    static private func doStartByType(_ netID: Int){
        if (0 != netID & OmniAds.NetType.Chartboost.rawValue)
        {
            adsWeight[NetType.Chartboost] = 1
            chartboost.start()
        }
        if (0 != netID & OmniAds.NetType.Vungle.rawValue)
        {
            adsWeight[NetType.Vungle] = 1
            vungle.start()
        }
        if (0 != netID & OmniAds.NetType.Adcolony.rawValue)
        {
            adsWeight[NetType.Adcolony] = 1
            adcolony.start()
        }
        if (0 != netID & OmniAds.NetType.Applovin.rawValue)
        {
            adsWeight[NetType.Applovin] = 1
            applovin.start()
        }
        if (0 != netID & OmniAds.NetType.Inmobi.rawValue)
        {
            adsWeight[NetType.Inmobi] = 1
            inmobi.start()
        }
        if (0 != netID & OmniAds.NetType.Smaato.rawValue)
        {
            adsWeight[NetType.Smaato] = 1
            smaato.start()
        }
        if (0 != netID & OmniAds.NetType.Tapjoy.rawValue)
        {
            adsWeight[NetType.Tapjoy] = 1
            tapjoy.start()
        }
        if (0 != netID & OmniAds.NetType.Ironsource.rawValue)
        {
            adsWeight[NetType.Ironsource] = 1
            ironsource.start()
        }
        if (0 != netID & OmniAds.NetType.Startapp.rawValue)
        {
            adsWeight[NetType.Startapp] = 1
            startapp.start()
        }
    }
    
    static private func doStart(completion:(Bool)->Void){
        doStartByType(adsConfig.net_id)
        completion(adsConfig.allow)
    }

    static private func fetchConfig(completion: @escaping(Bool)->Void){
        let urlString =  "http://128.199.105.96:12002/app/"+Bundle.main.bundleIdentifier!
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                DispatchQueue.main.async {
                    if (nil != error ){
                        mLog("")
                        print (error)
                    }
                    else if let safeData = data{
                        parseJSON(configData: safeData)
                    }
                    doStart(completion:completion)
                }
            }
            task.resume()
        }
    }
    public static func start(completion:@escaping(Bool)->Void){
        mLog("")
        fetchConfig(completion:completion)        
    }
    
    public static func showInterstitial(viewController: UIViewController, completion: @escaping(Bool)->Void){
        let netType = chooseNetByWeight()
        switch netType {
        case .None:
            mLog("")
            return
        case .Chartboost:
            chartboost.showInterstitial()
        case .Vungle:
            vungle.showInterstitial(viewController)
        case .Adcolony:
            adcolony.showInterstital()
        case .Applovin:
            applovin.showInterstitial()
        case .Inmobi:
            inmobi.showInterstitial(viewController)
        case .Smaato:
            smaato.showInterstitial(viewController)
        case .Tapjoy:
            tapjoy.showInterstitial(viewController)
        case .Ironsource:
            ironsource.showInterstital(viewController)
        case .Startapp:
            startapp.showInterstital()
        }
        

        completion(adsConfig.allow)
    }
}
