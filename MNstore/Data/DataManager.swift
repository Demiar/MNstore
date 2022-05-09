//
//  DataManager.swift
//  MNstore
//
//  Created by Алексей on 23.04.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    var category: [Category] = []
    var currentCategoryId: Int = 0
    var productsOnPage: [Int: [Product]] = [:]
    var productPage: Dictionary<Int, Int> = [:]
    
    private let networkManager = NetworkManager()

    
    enum ProductPage {
        case currentPage(Int)
        case numPage(Int)
        case pageSize(Int)
        case productCount(Int)
        case sectionId(Int)
    }
    
    private init() {
        networkManager.loadData(urlString: "\(Constants.siteUrl)category.php", parameters: [:]){ (result: Result<[Category], Error>) in
            switch result {
            case .success(let category):
                self.category = category
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getNameCategory(id: Int) -> String {
        var result = "Каталог"
        result = category.first(where: {$0.id == id})?.name ?? "Каталог"
        return result
    }
    
    func getCategoriesByParent(parentId: Int) -> [Category] {
        var result: [Category] = []
        
        for cat in category {
            if cat.parentID == parentId {
                result.append(cat)
            }
        }

        return result
    }
    
    func getCategoryByParent(id: Int, category: [Category]) -> [Int] {
        var result: [Int] = [id]
        var num = 0
        while num < result.count {
            for cat in category {
                if cat.parentID == result[num] {
                    result.append(cat.id)
                }
            }
            num += 1
        }

        return result
    }
    
//    func countProductsCategory(categoryId: Int) -> Int {
//        var result: Int = 0
//        var categories = getCategoryByParent(id: categoryId, category: category)
//        while categories.count != 0 {
//            for value in categories {
//                for product in products {
//                    if product.sectionID == value {
//                        result += 1
//                    }
//                }
//                categories.remove(at: 0)
//            }
//        }
////        for product in products {
////            if product.sectionID == categoryId {
////                result += 1
////            }
////        }
//        return result
//    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    private func parseCategory(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([Category].self,
                                                       from: jsonData)
            category = decodedData
        } catch {
            print(error)
        }
    }
    
    private func parseProduct(jsonData: Data) -> [Product] {
        var result: [Product] = []
        do {
            let decodedData = try JSONDecoder().decode([Product].self,
                                                       from: jsonData)
            result = decodedData
        } catch {
            print(error)
        }

        return result
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
