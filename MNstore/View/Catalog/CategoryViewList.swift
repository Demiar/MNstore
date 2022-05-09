//
//  CategoryList.swift
//  MNstore
//
//  Created by Алексей on 03.05.2022.
//

import SwiftUI

struct CategoryViewList: View {
    @ObservedObject var categoryManager: CategoryManager
    
    var body: some View {
        if categoryManager.categories.isEmpty {
            if categoryManager.getElementsCount(categoryId: categoryManager.categoryId) == 0 {
                ProgressView()
            }

        } else {
            List(categoryManager.categories, id: \.id){ category in
                if category.active == "Y" {
                    NavigationLink(destination: {
                        CategoryViewList(categoryManager: CategoryManager(categoryId: category.id, category: category))
                    }){
                        HStack{
                            Text("\(category.name) - \(category.id)")
                                .font(.headline)
                            Text("\(category.elementCount)")
                                .font(.system(size: 10, weight: .thin, design: .default))

                        }
                    }
                }

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(categoryManager.getName(id: categoryManager.categoryId))
        }
        if categoryManager.getElementsCount(categoryId: categoryManager.categoryId) != 0 {
            ProductViewList(categoryId: categoryManager.categoryId, category: categoryManager.category)
                .navigationTitle(categoryManager.getName(id: categoryManager.categoryId))
        }

    }
}
