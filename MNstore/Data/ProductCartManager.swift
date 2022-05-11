//
//  ItemsCart.swift
//  MNstore
//
//  Created by Алексей on 17.04.2022.
//

import Foundation

class ProductCartManager: ObservableObject {
    static let shared = ProductCartManager()
    @Published var products: [ProductCart] = []
    @Published var cartEmpty: Bool = true
    private let networkManager = NetworkManager()
    private let authManager = AuthManager.shared
    
    init(){
        loadCart()
    }
    
    private func loadCart() {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.cart)/", parameters: ["userId": String(authManager.getUserId()),
                                                                                                         "type":"getBasket"]) { (result: Result<[ProductCart], Error>) in
            switch result {
            case .success(let products):
                self.products = products
                if self.products.count == 0 {
                    self.cartEmpty = true
                } else {
                    self.cartEmpty = false
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addCart(productId: Int, price: Int, quantity: Int) {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.cart)/",
                                parameters: ["type": "addProduct",
                                            "userId": "\(authManager.getUserId())",
                                            "id": "\(productId)",
                                            "quantity": "\(quantity)",
                                            "price": "\(price)"]){ (result: Result<String, Error>) in
            switch result {
            case .success(_):
                self.loadCart()
            case .failure(let error):
                print(error)
            }
        }
    }

    func deleteCart(productId: Int, quantity: Int) {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.cart)/",
                                parameters: ["type": "deleteProduct",
                                            "userId": "\(authManager.getUserId())",
                                            "id": "\(productId)",
                                            "quantity": "\(quantity)"]){ (result: Result<String, Error>) in
            switch result {
            case .success(_):
                self.loadCart()
            case .failure(let error):
                print(error)
            }
        }
    }

    func sumCart() -> Float {
        var sum: Float = 0.0
        for item in products {
            sum += Float(item.price * item.quantity)
        }

        return sum
    }
}
