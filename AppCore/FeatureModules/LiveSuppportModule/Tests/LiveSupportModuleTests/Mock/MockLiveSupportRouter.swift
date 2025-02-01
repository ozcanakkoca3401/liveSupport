//
//  MockLiveSupportRouter.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation
@testable import LiveSupportModule

final class MockLiveSupportRouter: LiveSupportRouterProtocol {
    var isCloseApplicationCalled = false

    func openURLInSafari(url: URL) {}

    func closeApplication() {
        isCloseApplicationCalled = true
    }
}
