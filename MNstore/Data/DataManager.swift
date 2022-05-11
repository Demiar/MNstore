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
    
    private let networkManager = NetworkManager()
    
    private init() {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.category)/", parameters: [:]){ (result: Result<[Category], Error>) in
            switch result {
            case .success(let category):
                self.category = category
            case .failure(let failure):
                print(failure)
            }
        }
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
