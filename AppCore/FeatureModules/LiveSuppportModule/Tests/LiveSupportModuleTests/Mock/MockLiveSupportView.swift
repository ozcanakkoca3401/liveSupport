//
//  MockLiveSupportView.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation
@testable import LiveSupportModule

final class MockLiveSupportView: LiveSupportViewProtocol {
    var receivedTitle: String?

    func handleOutput(_ output: LiveSupportPresenterOutput) {
        if case let .setTitle(title) = output {
            receivedTitle = title
        }
    }
}
