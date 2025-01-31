//
//  Environment.swift
//  CoreNetwork
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation

public enum Environment {
    case development
    case staging
    case production
    
    public var baseURL: String {
        switch self {
        case .development:
            return "wss://dev-websocket.example.com"
        case .staging:
            return "wss://staging-websocket.example.com"
        case .production:
            return "wss://echo.websocket.org"
        }
    }
}
