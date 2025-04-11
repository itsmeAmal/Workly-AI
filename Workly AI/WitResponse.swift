//
//  WitResponse.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-11.
//

// WitResponse.swift
import Foundation

struct WitResponse: Codable {
    let text: String
    let intents: [WitIntent]
    let entities: [String: [WitEntity]]
}

struct WitIntent: Codable {
    let name: String
    let confidence: Double
}

struct WitEntity: Codable {
    let confidence: Double
    let value: String
}
