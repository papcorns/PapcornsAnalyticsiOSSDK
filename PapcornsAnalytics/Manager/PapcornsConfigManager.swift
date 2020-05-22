//
//  PapcornsConfigManager.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation
import UIKit

class PapcornsConfigManager {
    
    static let shared = PapcornsConfigManager()
    private (set) var config : PapcornsConfiguration
    
    private init() {
        config = PapcornsConfiguration()
    }
    
}
