//
//  OmniAds.swift
//  AutoAdsSwift
//
//  Created by minh on 3/25/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation
class OmniAds{
    enum NetType: Int{
        case None = 0
        case Chartboost = 0x01
        case Vungle = 0x02
        case Adcolony = 0x04
        case Applovin = 0x08
        case Inmobi  = 0x10
        case Smaato = 0x20
        case Tapjoy = 0x40
        case Ironsource = 0x80
        case Startapp = 0x100
    }
    
    static let chartboost = AdsChartboost()
    static let vungle = AdsVungle()
    static let adcolony = AdsAdcolony()
    static let applovin = AdsApplovin()
    static let inmobi = AdsInmobi()
    static let smaato = AdsSmaato()
    static let tapjoy = AdsTapjoy()
    static let ironsource = AdsIronsource()
    static let startapp = AdsStartapp()
  
    static func parseJSON(configData: Data){
        let decoder = JSONDecoder()

        do {
            mLog("")

            adsConfig = try decoder.decode(ConfigurationAds.self, from: configData)
            mLog("chartboost_app_id="+adsConfig.chartboost_app_id)
            mLog("chartboost_app_signature="+adsConfig.chartboost_app_signature)
            mLog("tapjoy_sdk_key="+adsConfig.tapjoy_sdk_key)
            mLog("tapjoy_placement_name="+adsConfig.tapjoy_placement_name)

        } catch {
            mLog("")

            print(error)
        }
        
    }
    static private func fetchConfig(){
        mLog("")

        let urlString =  "http://128.199.105.96:12002/app/"+Bundle.main.bundleIdentifier!
        mLog(urlString)
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                DispatchQueue.main.async {
                    if (nil != error ){
                        mLog("")
                        print (error)
                    }
                    else if let safeData = data{
                        mLog("")

                        parseJSON(configData: safeData)
                    }
                    mLog("thread="+String(Thread.current.isMainThread))

                    doStart()
                }
            }
            task.resume()
        }
    }

    static private func doStart(){
        mLog("")
        chartboost.start()
        vungle.start()
        adcolony.start()
        applovin.start()
        inmobi.start()
        smaato.start()
        tapjoy.start()
        ironsource.start()
        startapp.start()
    }
    
    public static func startAll(){
        mLog("thread="+String(Thread.current.isMainThread))
        fetchConfig()
        //doStart()
    }
    
    public static func showInterstitial(netType: NetType, viewController: UIViewController) {
        switch netType {
        case .None:
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
        return
    }
  
    public static func showInterstitialAll(_ viewController: UIViewController) {
        mLog("")
        chartboost.showInterstitial()
        vungle.showInterstitial(viewController)
        adcolony.showInterstital()
        applovin.showInterstitial()
        inmobi.showInterstitial(viewController)
        smaato.showInterstitial(viewController)
        tapjoy.showInterstitial(viewController)
        ironsource.showInterstital(viewController)
        startapp.showInterstital()
    }
    
    static var adsWeight: [NetType: Int] = [NetType.Chartboost:0, NetType.Vungle:0, NetType.Adcolony:0, NetType.Applovin:0, NetType.Inmobi:0, NetType.Smaato:0, NetType.Tapjoy:0, NetType.Ironsource:0,NetType.Startapp:0]
    
    static func chooseNetByWeight() -> NetType{
        var weightSum = 0
        for (_,weight) in adsWeight{
            weightSum += weight
        }
        
        let temp = String(weightSum)
        mLog("weightSum="+temp)
        
        if 0 == weightSum{
            return NetType.None
        }
        
        var randomNum = Int.random(in: 0 ... weightSum - 1)
        for (net,weight) in adsWeight{
            if randomNum < weight{
                return net
            }
            randomNum -= weight
        }
        assertionFailure("never come here")
        return NetType.None
    }
    
}
