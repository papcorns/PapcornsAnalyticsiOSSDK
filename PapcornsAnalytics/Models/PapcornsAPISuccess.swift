//
//  PapcornsAPISuccess.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

class PapcornsAPISuccess: Codable {

    var status:String?
    var message:String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
    
}
