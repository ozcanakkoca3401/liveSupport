//
//  NetworkMonitor.swift
//  CoreNetwork
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Network
import Foundation

public let networkStatusChangedNotification = Notification.Name("networkStatusChanged")

public class NetworkMonitoringManager {
    public static let shared = NetworkMonitoringManager()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    private init() {}
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            let status = path.status == .satisfied
            NotificationCenter.default.post(name: networkStatusChangedNotification, object: status)
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
