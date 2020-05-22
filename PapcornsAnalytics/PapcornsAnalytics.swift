//
//  PapcornsAnalytics.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

public class PapcornsAnalytics {

    public static var appId:String {
        set {
            PapcornsConfigManager.shared.config.appId = newValue
        }
        get {
            return PapcornsConfigManager.shared.config.appId
        }
    }
    
    public static var appVersion:String {
        set {
            PapcornsConfigManager.shared.config.appVersion = newValue
        }
        get {
            return PapcornsConfigManager.shared.config.appVersion
        }
    }
    
    public static var userId:String {
        set {
            PapcornsConfigManager.shared.config.userId = newValue
        }
        get {
            return PapcornsConfigManager.shared.config.userId
        }
    }
    
    public static func configure(appId:String,
                          appVersion:String) {
        PapcornsConfigManager.shared.config.appId = appId
        PapcornsConfigManager.shared.config.appVersion = appVersion
    }
    
    public static func logScreen(screenName : String , screenParameters : [String:Any]) {
        PapcornsAPILogScreen.init(screenName: screenName, screenParameters: screenParameters).request()
    }

    public static func logEvent(eventName : String , eventParameters : [String:Any]) {
        PapcornsAPILogEvent.init(eventName: eventName, eventParameters: eventParameters).request()
    }
    
    public static func setUserId(userId : String) {
        PapcornsConfigManager.shared.config.userId = userId
        PapcornsAPISetUser.init(userId: userId).request()
    }
}
