//
//  WebSocketClient.swift
//  CoreNetwork
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation
import UIKit

public protocol WebSocketClientProtocol {
    var delegate: WebSocketClientDelegate? { get set }
    
    func connect(to urlString: String)
    func send(message: String)
    func disconnect()
}

public protocol WebSocketClientDelegate: AnyObject {
    func webSocketDidConnect()
    func webSocketDidReceiveMessage(_ message: String)
    func webSocketDidReceiveData(_ data: Data)
    func webSocketDidFail(with error: WebSocketError)
    func webSocketDidDisconnect()
}

public extension WebSocketClientDelegate {
    func webSocketDidReceiveData(_ data: Data) { }
    func webSocketDidConnect() { }
    func webSocketDidDisconnect() { }
}

public class WebSocketClient: WebSocketClientProtocol {
    private var webSocketTask: URLSessionWebSocketTask?
    public weak var delegate: WebSocketClientDelegate?
    
    private var isConnected = false
    private var reconnectAttempts = 0
    
    private var pingTimer: Timer?
    
    public init() {
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func connect(to urlString: String = Environment.production.baseURL) {
        guard let url = URL(string: urlString) else {
            delegate?.webSocketDidFail(with: .invalidURL)
            return
        }

        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        isConnected = true
        reconnectAttempts = 0
        
        delegate?.webSocketDidConnect()
        startPing()
        receive()
    }

    public func send(message: String) {
        let jsonMessage = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(jsonMessage) { [weak self] error in
            if let error = error {
                self?.delegate?.webSocketDidFail(with: .messageSendFailed(error))
            }
        }
    }

    private func receive() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.delegate?.webSocketDidReceiveMessage(text)
                case .data(let data):
                    self?.delegate?.webSocketDidReceiveData(data)
                @unknown default:
                    break
                }
                self?.receive()
                
            case .failure(let error):
                self?.handleDisconnect()
            }
        }
    }

    public func disconnect() {
        stopPing()
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        delegate?.webSocketDidDisconnect()
    }
    
}

// MARK: - Methods
private extension WebSocketClient {
    private func handleDisconnect() {
        if isConnected {
            reconnectAttempts += 1
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                self.connect()
            }
        }
    }
    
    private func startPing() {
        stopPing()
        
        pingTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.sendPing()
        }
    }
    
    private func sendPing() {
        webSocketTask?.sendPing { _ in }
    }
    
    private func stopPing() {
        pingTimer?.invalidate()
        pingTimer = nil
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleAppDidEnterBackground() {
        stopPing()
    }
    
    @objc private func handleAppWillEnterForeground() {
        startPing()
    }

}
    
