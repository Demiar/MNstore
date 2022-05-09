//
//  Product.swift
//  MNstore
//
//  Created by Алексей on 16.04.2022.
//

import Foundation

struct Product: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let quantity, price: Int
    let previewPicture, detailPicture: String
    let sectionId: Int
}
