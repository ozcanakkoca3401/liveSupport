//
//  LiveSupportRouter.swift
//  AppCore
//
//  Created by Özcan AKKOCA on 29.01.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: - Router
public final class LiveSupportRouter {
    private weak var moduleViewController: LiveSupportViewController?
    
    public init () {}
}

extension LiveSupportRouter {
    public func start()  -> LiveSupportViewController {
        let viewController = initModule()
        self.moduleViewController = viewController
        return viewController
    }
    
    func initModule() -> LiveSupportViewController {
        let viewController = LiveSupportViewController()
        let interactor = LiveSupportInteractor()
        let presenter = LiveSupportPresenter(view: viewController,
                                               interactor: interactor,
                                               router: self)
        interactor.delegate = presenter
        viewController.presenter = presenter
        self.moduleViewController = viewController
        return viewController
    }
}

// MARK: - LiveSupportRouterProtocol
extension LiveSupportRouter: LiveSupportRouterProtocol {
    func openURLInSafari(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func closeApplication() {
        moduleViewController?.dismiss(animated: true)
    }
}
