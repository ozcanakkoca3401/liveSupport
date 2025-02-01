//
//  HomeViewModel.swift
//  HomeModule
//
//  Created by Özcan AKKOCA on 28.01.2025.
//
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    // Add your custom methods here
    func liveSupportTapped()
    
    var outputHandler: ((HomeViewModel.HomeOutput) -> Void)? { set get }
}

final class HomeViewModel {
    
    enum HomeOutput {
        case setLoading(_ isLoading: Bool)
        case showError(_ message: String)
    }
    
    var outputHandler: ((HomeOutput) -> Void)?

    private let router: HomeRouterProtocol
    private let service: HomeRepositoryProtocol
    
    init(router: HomeRouterProtocol,
         service: HomeRepositoryProtocol) {
        self.router = router
        self.service = service
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func liveSupportTapped() {
        router.presentLiveSupport()
    }
    
}

