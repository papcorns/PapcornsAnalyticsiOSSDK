//
//  PapcornsAPIError.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

class PapcornsAPIError: Codable {

    var status:String?
    var message:String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
    
    var error : PapcornsError {
        return .UnknownError
    }
}
