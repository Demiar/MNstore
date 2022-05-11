//
//  ProductManager.swift
//  MNstore
//
//  Created by Алексей on 03.05.2022.
//

import Foundation


class ProductManager: ObservableObject {
    var categoryId: Int
    var category: Category
    @Published var products: [Product] = []
    @Published var product: Product?
    @Published var isLoading: Bool = false
    private var canLoadMorePages: Bool = true
    private var networkManager = NetworkManager()
    private var numPage: Int = 1
    private var pageSize: Int = 20
    
    init(categoryId: Int, category: Category) {
        self.categoryId = categoryId
        self.category = category
        loadProducts(sectionId: categoryId)
    }
    
    func loadProduct(id: Int){
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.product)/",
                                parameters: ["id" : "\(id)",
                                             "type" : "getProduct"
                                            ]
        ) { (result: Result<Product, Error>) in
            switch result {
            case .success(let product):
                self.product = product
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func loadProducts(sectionId: Int) {
        guard !isLoading && canLoadMorePages else { return }
        isLoading = true
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.product)/",
                                parameters: ["sectionId" : "\(sectionId)",
                                             "type": "getProducts",
                                            "numPage" : "\(numPage)",
                                            "pageSize" : "\(pageSize)"
                                            ]
        ) { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                if !products.isEmpty {
                    self.products += products
                }
                self.numPage += 1
                if self.category.elementCount <= (self.numPage * self.pageSize) {
                    self.canLoadMorePages = false
                }
                self.isLoading = false
            case .failure(let error):
                    print(error)
            }
        }
    }
}
