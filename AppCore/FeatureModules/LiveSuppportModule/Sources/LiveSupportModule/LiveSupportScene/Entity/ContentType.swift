//
//  ContentType.swift
//  LiveSupportModule
//
//  Created by Özcan AKKOCA on 31.01.2025.
//

enum ContentType: Codable {
    case text(String)
    case model(Content)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Eğer `content` bir string ise:
        if let text = try? container.decode(String.self) {
            self = .text(text)
            return
        }
        
        // Eğer `content` bir model ise:
        if let model = try? container.decode(Content.self) {
            self = .model(model)
            return
        }
        
        throw DecodingError.typeMismatch(ContentType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Content is neither a String nor a Content object."))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .text(let text):
            try container.encode(text)
        case .model(let model):
            try container.encode(model)
        }
    }
}
