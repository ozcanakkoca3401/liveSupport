//
//  LiveSupportPresenter.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 29.01.2025.
//

import Foundation
import CoreNetwork
import CoreResource

final class LiveSupportPresenter {
  
    private var items: [LiveSupportMessageRowType] = []
    
    private weak var view: LiveSupportViewProtocol?
    private let interactor: LiveSupportInteractorProtocol
    private let router: LiveSupportRouterProtocol
    
    init(view: LiveSupportViewProtocol,
         interactor: LiveSupportInteractorProtocol,
         router: LiveSupportRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LiveSupportPresenterProtocol
extension LiveSupportPresenter: LiveSupportPresenterProtocol {
    func viewDidLoad() {
        interactor.connectToWebSocket()
        interactor.getOptions()
        interactor.sendStep("step_1", isAsistant: false)
        interactor.startMonitoringNetwork()
    }
    
    func viewWillDisappear() {
        interactor.disconnectWebSocket()
    }
    
    func handleExitRequest() {
        router.closeApplication()
    }
    
    func loadTitle() {
        interactor.loadTitle()
    }
    
    func didSelectProduct(at itemIndex: Int, optionIndex: Int) {
        if case .product(let presentation) = items[itemIndex], let imageUrl = presentation.products[optionIndex].imageUrl {
            router.openURLInSafari(url: imageUrl)
        } else {
            view?.handleOutput(.showErrorMessage(CoreLocalize.General.Error))
        }
    }
    
    func didSelectOption(at itemIndex: Int, optionIndex: Int) {
        if itemIndex < items.count, case .message(let presentation) = items[itemIndex] {
            let value = presentation.subItemPresentation.options[optionIndex].value
            if value == ActionType.endConversation.rawValue {
                view?.handleOutput(.showExitPopup)
            } else {
                interactor.sendStep(value, isAsistant: !presentation.isLeft)
            }
        } else {
            view?.handleOutput(.showErrorMessage(CoreLocalize.General.Error))
        }
    }
    
}

// MARK: - LiveSupportInteractorDelegate
extension LiveSupportPresenter: LiveSupportInteractorDelegate {
    
    func handleOutput(_ output: LiveSupportInteractorOutput) {
        switch output {
        case .setTitle(let text):
            view?.handleOutput(.setTitle(text))
        case .addStep(let step):
            if let optionResponse = interactor.options.filter({ $0.step == step.step }).first {
                let type: LiveSupportMessageRowType
                if optionResponse.type == .image {
                    type = .product(presentation: LiveSupportProductTableViewCellPresentation(with: optionResponse))
                } else {
                    type = .message(presentation: LiveSupportTableViewCellPresentation(with: optionResponse, isLeft: step.isAssistant))
                }
                
                self.items.append(type)

            }
            view?.handleOutput(.setListItems(items))
        case .showErrorMessage(let message):
            view?.handleOutput(.showErrorMessage(message))
        }
    }
}
