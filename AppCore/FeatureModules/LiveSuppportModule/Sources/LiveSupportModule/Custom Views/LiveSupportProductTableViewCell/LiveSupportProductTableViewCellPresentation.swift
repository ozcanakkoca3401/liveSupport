//
//  LiveSupportProductTableViewCellPresentation.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import Foundation

struct LiveSupportProductTableViewCellPresentation: Hashable {
    let id: UUID = UUID()
    let products: [LiveSupportProductItemPresentation]
}

extension LiveSupportProductTableViewCellPresentation {
    init(with response: OptionResponse) {
        if case let .text(imageUrl) = response.content, response.action == .showGuide {
            products = [.init(orderNumber: "TRX123456789",
                              orderStatus: "Kargoda",
                              orderDate: "23-09-2024",
                              title: "Akim Korumali Priz",
                              imageUrl: URL(string: imageUrl))]
                
        } else {
            products = .emptyValue
        }
    }
}
