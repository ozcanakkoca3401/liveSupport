//
//  HomeRouter.swift
//  HomeModule
//
//  Created by Özcan AKKOCA on 28.01.2025.
//
//

import UIKit
import LiveSupportModule

// MARK: - RoutingProtocol
protocol HomeRouterProtocol: AnyObject {
    func presentLiveSupport()
}

// MARK: - Router
public final class HomeRouter {
    
    private weak var moduleViewController: MVVMHomeViewController?

    public init () {}
}

extension HomeRouter {
    public func start()  -> MVVMHomeViewController {
        let viewController = initModule()
        self.moduleViewController = viewController
        return viewController
    }
    
    private func initModule() -> MVVMHomeViewController {
        let viewController = MVVMHomeViewController()
        let viewModel = HomeViewModel(router: self, service: HomeRepository())
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    func presentLiveSupport() {
        let vc = UINavigationController(rootViewController: LiveSupportRouter().start())
        vc.modalPresentationStyle = .fullScreen
        moduleViewController?.present(vc, animated: true)
    }
}
