//
//  PapcornsAPISetUser.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

class PapcornsAPISetUser: PapcornsRequest<PapcornsAPISuccess> {
    
    convenience init(userId : String, tools : [PapcornsToolsConfig]) {
        self.init()
        
        addBodyItem(name: "userId", value: PapcornsConfigManager.shared.config.userId)
        addBodyItem(name: "idfa", value: PapcornsConfigManager.shared.config.idfa ?? "")
        addBodyItem(name: "deviceId", value: PapcornsConfigManager.shared.config.deviceId ?? "")
        addBodyItem(name: "deviceModel", value: PapcornsConfigManager.shared.config.deviceModel ?? "")
        addBodyItem(name: "deviceVersion", value: PapcornsConfigManager.shared.config.osVersion ?? "")
        addBodyItem(name: "preferedLanguage", value: PapcornsConfigManager.shared.config.language ?? "")
        addBodyItem(name: "country", value: PapcornsConfigManager.shared.config.country ?? "")
        addBodyItem(name: "ip", value: PapcornsConfigManager.shared.config.ip ?? "")
        addBodyItem(name: "appId", value: PapcornsConfigManager.shared.config.appId)
        addBodyItem(name: "appVersion", value: PapcornsConfigManager.shared.config.appVersion)
        
        var toolsDict = [[String:Any]]()
        tools.forEach { (config) in
            
            //Default values
            var tool:[String:Any] = [
                "key":config.key
            ]
            
            switch config {
                case .Adjust(let adjustId):
                    if let adjustId = adjustId {
                    tool["adId"] = adjustId
                }
                case .AppsFlyer(let uId):
                    if let uId = uId {
                    tool["uId"] = uId
                }
            }
            
            toolsDict.append(tool)
        }
        
        addBodyItem(name: "tools", value: toolsDict)
    }
    
    override var httpMethod: HTTPMethod {
        return .POST
    }

    override var path: String {
        return "/userLog"
    }

}
