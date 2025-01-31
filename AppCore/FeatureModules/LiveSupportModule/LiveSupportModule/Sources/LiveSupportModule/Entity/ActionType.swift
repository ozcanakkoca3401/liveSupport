//
//  ActionType.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

import Foundation

enum ActionType: String, Codable {
    case awaitUserChoice = "await_user_choice"
    case endConversation = "end_conversation"
    case showGuide = "show_guide"
}
