//
//  DisplayNameEntity.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-12.
//

import Foundation

struct DisplayNameEntity: Decodable {
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
    }
}
