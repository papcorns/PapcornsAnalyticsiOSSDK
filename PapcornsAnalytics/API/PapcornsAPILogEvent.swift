//
//  PapcornsAPILogEvent.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

class PapcornsAPILogEvent: PapcornsRequest<PapcornsAPISuccess> {
    
    convenience init(eventName : String,eventParameters : [String : Any]) {
        self.init()
        
        addBodyItem(name: "userId", value: PapcornsConfigManager.shared.config.userId)
        addBodyItem(name: "eventName", value: eventName)
        addBodyItem(name: "eventParameters", value: eventParameters)
        addBodyItem(name: "appId", value: PapcornsConfigManager.shared.config.appId)
        addBodyItem(name: "appVersion", value: PapcornsConfigManager.shared.config.appVersion)
        
    }
    
    override var httpMethod: HTTPMethod {
        return .POST
    }

    override var path: String {
        return "/logEvent"
    }

}
