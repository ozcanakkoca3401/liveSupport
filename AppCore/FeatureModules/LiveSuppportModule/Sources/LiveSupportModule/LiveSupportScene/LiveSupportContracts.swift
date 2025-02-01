//
//  LiveSupportContracts.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation


// MARK: - Interactor
protocol LiveSupportInteractorProtocol: AnyObject {
    func startMonitoringNetwork()
    func loadTitle()
    func connectToWebSocket()
    func sendStep(_ step: String, isAsistant: Bool)
    func getOptions()
    func disconnectWebSocket()
    
    var options: [OptionResponse] { get }
}

protocol LiveSupportInteractorDelegate: AnyObject {
    func handleOutput(_ output: LiveSupportInteractorOutput)
    
}

enum LiveSupportInteractorOutput {
    case setTitle(_ text: String)
    case addStep(_ step: OptionSocketRequestResponse)
    case showErrorMessage(_ message: String)
}

// MARK: - Presenter
protocol LiveSupportPresenterProtocol: AnyObject {
    func loadTitle()
    func viewDidLoad()
    func viewWillDisappear()
    func handleExitRequest()
    func didSelectProduct(at itemIndex: Int, optionIndex: Int)
    func didSelectOption(at itemIndex: Int, optionIndex: Int)
}

enum LiveSupportPresenterOutput {
    case setTitle(_ text: String)
    case setListItems(_ items: [LiveSupportMessageRowType])
    case showErrorMessage(_ message: String)
    case showExitPopup
}

// MARK: - View
protocol LiveSupportViewProtocol: AnyObject {
    func handleOutput(_ output: LiveSupportPresenterOutput)
}

// MARK: - RoutingProtocol
protocol LiveSupportRouterProtocol: AnyObject {
    func openURLInSafari(url: URL)
    func closeApplication()
}
