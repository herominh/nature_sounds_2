//
//  Setting.swift
//  AutoAdsSwift
//
//  Created by minh on 3/25/20.
//  Copyright © 2020 spec. All rights reserved.
//

import Foundation

struct Constants{
    static let CHARTBOOST_APP_ID = "1";
    static let CHARTBOOST_APP_SIGNATURE = "1"

    static let VUNGLE_APP_ID = "1"
    static let VUNGLE_PLACEMENT_ID = "DEFAULT-1"
    
    static let ADCOLONY_APP_ID = "1"
    static let ADCOLONY_INTERSTITIAL_ZONE = "1"
    
    //AppLovinSdkKey refer info.plist
    
    static let INMOBI_ACCOUNT_ID = "1"
    static let INMOBI_INTERSTITIAL_PLACEMENT:Int64 = 1
    
    
    static let SMAATO_PUBLISHER_ID = "1"
    static let SMAATO_ADSPACE_ID = "1"
    //static let SMAATO_PUBLISHER_ID = "1100042525"
    //static let SMAATO_ADSPACE_ID = "130626426"
    
    static let TAPJOY_SDK_KEY = "1-9nGk592lBLl"
    static let TAPJOY_PLACEMENT_NAME = "1"
    
    static let IRONSOURCE_APP_KEY = "1"
        
    static let STARTAPP_APP_ID = "1"
}
class ConfigurationAds: Decodable{
    var allow:Bool{return _allow ?? false}
    var net_id: Int { return _net_id ??  OmniAds.NetType.Chartboost.rawValue}

    var chartboost_app_id: String { return _chartboost_app_id ?? Constants.CHARTBOOST_APP_ID}
    var chartboost_app_signature: String { return _chartboost_app_signature ?? Constants.CHARTBOOST_APP_SIGNATURE}
  
    var vungle_app_id: String { return _vungle_app_id ?? Constants.VUNGLE_APP_ID}
    var vungle_placement_id: String { return _vungle_placement_id ??  Constants.VUNGLE_PLACEMENT_ID}
    
    var adcolony_app_id: String { return _adcolony_app_id ??  Constants.ADCOLONY_APP_ID}
    var adcolony_interstitial_zone: String { return _adcolony_app_id ??  Constants.ADCOLONY_INTERSTITIAL_ZONE}
    
    //applovinsdkkey refer info.plist
    
    var inmobi_account_id: String { return _inmobi_account_id ??  Constants.INMOBI_ACCOUNT_ID}
    var inmobi_interstitial_placement: Int64 { return  _inmobi_interstitial_placement ?? Constants.INMOBI_INTERSTITIAL_PLACEMENT}
    
    var smaato_publisher_id: String { return _smaato_publisher_id ??  Constants.SMAATO_PUBLISHER_ID}
    var smaato_adspace_id: String { return  _smaato_adspace_id ??  Constants.SMAATO_ADSPACE_ID}
    
    var tapjoy_sdk_key: String { return _tapjoy_sdk_key ?? Constants.TAPJOY_SDK_KEY}
    var tapjoy_placement_name: String { return _tapjoy_placement_name ??  Constants.TAPJOY_PLACEMENT_NAME}
    
    var ironsource_app_key: String { return _ironsource_app_key ?? Constants.IRONSOURCE_APP_KEY}
    
    var startapp_app_id: String { return _startapp_app_id ?? Constants.STARTAPP_APP_ID}
    
    private var _allow: Bool?
    private var _net_id: Int?
    private var _chartboost_app_id: String?
    private var _chartboost_app_signature: String?
    private var _vungle_app_id: String?
    private var _vungle_placement_id: String?
    private var _adcolony_app_id: String?
    private var _adcolony_interstitial_zone: String?
    private var _inmobi_account_id: String?
    private var _inmobi_interstitial_placement: Int64?
    private var _smaato_publisher_id: String?
    private var _smaato_adspace_id: String?
    private var _tapjoy_sdk_key: String?
    private var _tapjoy_placement_name: String?
    private var _ironsource_app_key: String?
    private var _startapp_app_id: String?
    
    enum CodingKeys: String, CodingKey {
        case _allow = "allow"
        case _net_id = "net_id"
        case _chartboost_app_id = "chartboost_app_id"
        case _chartboost_app_signature = "chartboost_app_signature"
        case _vungle_app_id = "vungle_app_id"
        case _vungle_placement_id = "vungle_placement_id"
        case _adcolony_app_id = "adcolony_app_id"
        case _adcolony_interstitial_zone = "adcolony_interstitial_zone"
        case _inmobi_account_id = "inmobi_account_id"
        case _inmobi_interstitial_placement = "inmobi_interstitial_placement"
        case _smaato_publisher_id = "smaato_publisher_id"
        case _smaato_adspace_id = "smaato_adspace_id"
        case _tapjoy_sdk_key = "tapjoy_sdk_key"
        case _tapjoy_placement_name = "tapjoy_placement_name"
        case _ironsource_app_key = "ironsource_app_key"
        case _startapp_app_id = "startapp_app_id"
    }
}


//var adsConfig = ConfigurationAds(chartboost_app_id:Constants.CHARTBOOST_APP_ID)
var  adsConfig = ConfigurationAds()
