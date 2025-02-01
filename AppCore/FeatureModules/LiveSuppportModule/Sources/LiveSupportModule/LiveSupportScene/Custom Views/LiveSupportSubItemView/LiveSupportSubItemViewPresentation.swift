//
//  LiveSupportSubItemViewPresentation.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import UIKit
import CoreResource

struct LiveSupportSubItemViewPresentation: Hashable {
    let messageText: String
    let messageTextColor: UIColor
    let backgroundColor: UIColor
    let borderColor: UIColor
    let options: [LiveSupportSubItemOptionModel]
}

extension LiveSupportSubItemViewPresentation {
    init(isLeft: Bool, messageText: String, options: [LiveSupportSubItemOptionModel]) {
        self.messageText = messageText
        self.messageTextColor = isLeft ? CoreColors.black11: CoreColors.white11
        self.backgroundColor = isLeft ? CoreColors.gray11: CoreColors.purple11
        self.borderColor = isLeft ? CoreColors.border11: CoreColors.purple11
        self.options = options
    }
}

struct LiveSupportSubItemOptionModel: Hashable {
    let key: String
    let value: String
}
