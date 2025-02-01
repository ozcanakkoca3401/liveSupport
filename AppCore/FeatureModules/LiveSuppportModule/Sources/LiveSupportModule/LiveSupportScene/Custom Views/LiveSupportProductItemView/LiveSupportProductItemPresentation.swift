//
//  LiveSupportProductItemPresentation.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 30.01.2025.
//

import Foundation

struct LiveSupportProductItemPresentation: Hashable {
    let orderNumber: String
    let orderStatus: String
    let orderDate: String
    let title: String
    let imageUrl: URL?
}
