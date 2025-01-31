//
//  Content.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation

struct Content: Codable {
    let text: String?
    let buttons: [ButtonResponse]?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case text
        case buttons
        case imageUrl = "content"
    }
}
