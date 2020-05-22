//
//  PapcornsAPILogScreen.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

class PapcornsAPILogScreen: PapcornsRequest<PapcornsAPISuccess> {
    
    convenience init(screenName : String,screenParameters : [String : Any]) {
        self.init()
        
        addBodyItem(name: "userId", value: PapcornsConfigManager.shared.config.userId)
        addBodyItem(name: "eventName", value: screenName)
        addBodyItem(name: "eventParameters", value: screenParameters)
        addBodyItem(name: "appId", value: PapcornsConfigManager.shared.config.appId)
        addBodyItem(name: "appVersion", value: PapcornsConfigManager.shared.config.appVersion)
        
    }
    
    override var httpMethod: HTTPMethod {
        return .POST
    }

    override var path: String {
        return "/screenLog"
    }

}
