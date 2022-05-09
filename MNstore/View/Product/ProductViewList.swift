//
//  ProductList.swift
//  MNstore
//
//  Created by Алексей on 03.05.2022.
//

import SwiftUI

struct ProductViewList: View {
    @ObservedObject private var productManager: ProductManager
    var category: Category
    var categoryId: Int
    @State private var active: Bool = false
    
    init(categoryId: Int, category: Category) {
        self.categoryId = categoryId
        self.category = category
        productManager = ProductManager(categoryId: categoryId, category: category)
    }
    
    var body: some View {
  //      if productManager.products.isEmpty {
            //ProgressView()
  //      } else {
            List(productManager.products, id: \.id){ product in
                if product.sectionId == categoryId {
                    ZStack(alignment: .leading){
                        NavigationLink(destination: {
                            ProductViewDetail(product: product)
                        }){
                            //EmptyView()
                        }
                        .opacity(0)
                        ProductViewCell(product: product)
                            .onAppear{
                                if productManager.products.last == product {
                                    productManager.loadProducts(sectionId: categoryId)
                                }
                            }
                    }
                }
            }
            if productManager.isLoading {
                ProgressView()
            }
        //}
    }
}

