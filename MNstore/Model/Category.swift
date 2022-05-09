//
//  Category.swift
//  MNstore
//
//  Created by Алексей on 26.04.2022.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let parentID: Int
    let active: String
    let elementCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, active
        case parentID = "parent_id"
        case elementCount = "element_count"
    }
}
