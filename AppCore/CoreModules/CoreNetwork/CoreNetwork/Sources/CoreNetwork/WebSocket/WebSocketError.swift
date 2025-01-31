//
//  WebSocketError.swift
//  CoreNetwork
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation

public enum WebSocketError: LocalizedError {
    case invalidURL
    case connectionFailed(Error)
    case messageSendFailed(Error)
    case messageReceiveFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid WebSocket URL"
        case .connectionFailed(let error):
            return "WebSocket connection failed: \(error.localizedDescription)"
        case .messageSendFailed(let error):
            return "Failed to send message: \(error.localizedDescription)"
        case .messageReceiveFailed(let error):
            return "Failed to receive message: \(error.localizedDescription)"
        }
    }
}
