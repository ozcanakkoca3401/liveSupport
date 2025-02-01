//
//  LiveSupportInteractor.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation
import CoreResource
import CoreNetwork
import CoreExtension


final class LiveSupportInteractor: LiveSupportInteractorProtocol {

    private(set) var options: [OptionResponse] = .emptyValue
    weak var delegate: LiveSupportInteractorDelegate?

    private var webSocketClient: WebSocketClientProtocol
    private let service: ServiceProtocol

    init(service: ServiceProtocol = ServiceManager(),
         webSocketClient: WebSocketClientProtocol = WebSocketClient()) {
        self.service = service

        self.webSocketClient = webSocketClient
        self.webSocketClient.delegate = self
    }
    
    func loadTitle() {
        delegate?.handleOutput(.setTitle(CoreLocalize.LiveSupport.Title))
    }
    
    func getOptions() {
        service.fetchData { [weak self] (result: Result<[OptionResponse], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let options):
                self.options = options
            case .failure(let error):
                delegate?.handleOutput(.showErrorMessage(error.localizedDescription))
            }
        }
    }
    
    func connectToWebSocket() {
        webSocketClient.connect(to: Environment.production.baseURL)
    }
    
    func sendStep(_ step: String, isAsistant: Bool) {
        let requestModel = OptionSocketRequestResponse(step: step, isAssistant: isAsistant)
        guard let jsonMessage = requestModel.toJsonString() else {
            return
        }
        webSocketClient.send(message: jsonMessage)
    }
    
    func disconnectWebSocket() {
        webSocketClient.disconnect()
    }
    
    func startMonitoringNetwork() {
        NetworkMonitoringManager.shared.startMonitoring()
        
        NotificationCenter.default.addObserver(forName: networkStatusChangedNotification, object: nil, queue: .main) { [weak self] notification in
            if let status = notification.object as? Bool, !status {
                self?.delegate?.handleOutput(.showErrorMessage("Internet bağlantınızı kontrol ediniz."))
            }
        }
    }
}

// MARK: - WebSocketClientDelegate
extension LiveSupportInteractor: WebSocketClientDelegate {
    func webSocketDidReceiveMessage(_ message: String) {
        if let responseModel = OptionSocketRequestResponse.fromJsonString(message) {
            delegate?.handleOutput(.addStep(responseModel))
        }
    }
    
    func webSocketDidFail(with error: WebSocketError) {
        delegate?.handleOutput(.showErrorMessage(error.localizedDescription))
    }

}

