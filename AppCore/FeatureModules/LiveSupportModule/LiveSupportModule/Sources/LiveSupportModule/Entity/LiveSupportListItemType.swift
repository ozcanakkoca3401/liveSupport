//
//  LiveSupportListItemType.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import Foundation

enum LiveSupportMessageRowType: Hashable {
    case product(presentation: LiveSupportProductTableViewCellPresentation)
    case message(presentation: LiveSupportTableViewCellPresentation)
}
