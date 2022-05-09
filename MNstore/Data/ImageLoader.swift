//
//  ImageLoader.swift
//  MNstore
//
//  Created by Алексей on 05.05.2022.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    var url: String
    @Published var image: Image
    private let networkManager = NetworkManager()
    
    init(url: String) {
        self.url = url
        image = Image(systemName: "doc")
        load()
    }
    
    func load() {
        networkManager.loadImage(urlString: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                } else {
                    print("Image not loaded")
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
