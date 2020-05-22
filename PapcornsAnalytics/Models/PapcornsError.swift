//
//  PapcornsError.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

enum PapcornsError: Error {
    case UnknownError
}

extension PapcornsError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .UnknownError:
        return "Unknown error"
        }
    }
    
}
