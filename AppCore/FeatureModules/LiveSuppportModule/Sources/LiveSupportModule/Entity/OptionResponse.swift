//
//  OptionResponse.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation

struct OptionResponse: Codable {
    let step: String
    let type: StepType
    let content: ContentType
    let action: ActionType
}
