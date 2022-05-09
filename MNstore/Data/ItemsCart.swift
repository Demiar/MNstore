//
//  ItemsCart.swift
//  MNstore
//
//  Created by Алексей on 17.04.2022.
//

import Foundation

class ItemsCart: ObservableObject {
    static let shared = ItemsCart()
    
    @Published var itemsCart: [ProductCart] = [ProductCart(id: UUID(),
                                         product: Product(id: 10,
                                                          name: "test 213123 12312312 3213123",
                                                          quantity: 10,
                                                          price: 10,
                                                          previewPicture: "18030",
                                                          detailPicture: "18030",
                                                          sectionId: 123
                                                         ),
                                         count: 4,
                                         price: 159)
    ]
    
    private init(){
        //AuthManager().auth()
    }
    
    func addItemCart(product: Product, price: Float, count: Int) {
        let index = itemsCart.firstIndex(where: {$0.product.id == product.id})
        if let index = index {
            if itemsCart[index].count == product.quantity { return }
            itemsCart[index].count += count
        } else {
            itemsCart.append(ProductCart(id: UUID(),
                                      product: product,
                                      count: count,
                                      price: price)
            )
        }
    }
    
    func deleteItemCart(product: Product) {
        let index = itemsCart.firstIndex(where: {$0.product.id == product.id})
        if let index = index {
            itemsCart.remove(at: index)
        }
    }
    
    func sumCart() -> Float {
        var sum: Float = 0.0
        for item in itemsCart {
            sum += item.price * Float(item.count)
        }
        
        return sum
    }
}
