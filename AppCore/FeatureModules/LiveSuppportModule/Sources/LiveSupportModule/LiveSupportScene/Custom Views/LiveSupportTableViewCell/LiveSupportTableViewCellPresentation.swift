//
//  LiveSupportTableViewCellPresentation.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import Foundation

struct LiveSupportTableViewCellPresentation: Hashable {
    let id = UUID()
    let isLeft: Bool
    let subItemPresentation: LiveSupportSubItemViewPresentation
}

extension LiveSupportTableViewCellPresentation {
    init(with response: OptionResponse, isLeft: Bool) {
        self.isLeft = isLeft
        
        switch response.content {
        case .text(let text):
            self.subItemPresentation = .init(isLeft: isLeft,
                                                messageText: text,
                                                options: [])
        case .model(let model):
            let options = model.buttons?.map ({ LiveSupportSubItemOptionModel(key: $0.label, value: $0.action) }) ?? .emptyValue
            self.subItemPresentation = .init(isLeft: isLeft,
                                             messageText: model.text ?? .emptyValue,
                                                options: options)
        }
    }
}
