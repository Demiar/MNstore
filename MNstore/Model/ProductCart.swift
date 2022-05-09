//
//  ProductCart.swift
//  MNstore
//
//  Created by Алексей on 26.04.2022.
//

import Foundation

struct ProductCart: Identifiable {
    let id: UUID
    let product: Product
    var count: Int
    let price: Float
}
