//
//  ProductCart.swift
//  MNstore
//
//  Created by Алексей on 26.04.2022.
//

import Foundation

struct ProductCart: Identifiable, Decodable {
    let id, productId, price, fuserId: Int
    let currency, name: String
    var quantity: Int
    //let canBuy: Bool
}
