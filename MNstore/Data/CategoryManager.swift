//
//  CategoryManager.swift
//  MNstore
//
//  Created by Алексей on 22.04.2022.
//

import Foundation

class CategoryManager: ObservableObject {
    var categoryId: Int
    var category: Category
    @Published var categories: [Category] = []
    private var categoriesAll: [Category] = DataManager.shared.category
    
    var categoryCount: Int {
        get {
            categoriesAll.first(where: { $0.id == categoryId})?.elementCount ?? 0
        }
    }
    
    
    init(categoryId: Int, category: Category) {
        self.categoryId = categoryId
        self.category = category
        if categoriesAll.isEmpty {
            let networkManager = NetworkManager()
            networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.category)/", parameters: [:]){ (result: Result<[Category], Error>) in
                switch result {
                case .success(let category):
                    self.categoriesAll = category
                    self.categories = self.getCategories(categoryId: categoryId)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        categories = getCategories(categoryId: categoryId)
    }
    
    func getElementsCount(categoryId: Int) -> Int {
        var result = 0
        result = categoriesAll.first(where: { $0.id == categoryId})?.elementCount ?? 0
        return result
    }
    
    func getName(id: Int) -> String {
        var result = "Каталог"
        result = categoriesAll.first(where: { $0.id == id })?.name ?? "Каталог"
        return result
    }
    
    private func getCategories(categoryId value: Int = 0) -> [Category] {
        var result: [Category] = []
        for category in categoriesAll {
            if category.parentID == value {
                result.append(category)
            }
        }
        return result
    }

    
    func countProductsCategory(categoryId: Int) -> Int {
        var result = 0
        var categories = getCategories(categoryId: categoryId)
        while categories.count != 0 {
            for value in categories {
                result += value.elementCount
                categories.remove(at: 0)
            }
        }
        return result
    }
    
    func test(categoryId: Int) -> Int {
        var result = 0
        var num = [categoryId]
        while num.count > 0 {
            categories = getCategories(categoryId: num[0])
            while categories.count != 0 {
                for category in categories {
                    num.append(category.id)
                    result += category.elementCount
                }
            }
            num.remove(at: 0)
        }
        return result
    }
}
