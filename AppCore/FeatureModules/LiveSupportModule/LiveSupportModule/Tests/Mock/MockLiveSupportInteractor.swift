//
//  MockLiveSupportInteractor.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation
@testable import LiveSupportModule

final class MockLiveSupportInteractor: LiveSupportInteractorProtocol {
    var options: [LiveSupportModule.OptionResponse] = []
    
    var isConnectToWebSocketCalled = false
    var isSendStepCalled = false
    var isLoadTitleCalled = false
    weak var delegate: LiveSupportInteractorDelegate?

    func startMonitoringNetwork() {}

    func loadTitle() {
        isLoadTitleCalled = true
    }

    func connectToWebSocket() {
        isConnectToWebSocketCalled = true
    }

    func sendStep(_ step: String, isAsistant: Bool) {
        isSendStepCalled = true
    }

    func getOptions() {}

    func disconnectWebSocket() {}
}
