//
//  CatalogCellView.swift
//  MNstore
//
//  Created by Алексей on 18.04.2022.
//

import SwiftUI

struct ProductViewCell: View {
    var product: Product
    @ObservedObject private var imageLoader: ImageLoader
    
    init(product: Product) {
        self.product = product
        self.imageLoader = ImageLoader(url: product.previewPicture)
    }
    
    var body: some View {
        HStack{
            imageLoader.image
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                Text(product.name)
                    .font(.headline)
                    .frame(height: 100)
                    .lineLimit(4)
                Spacer()
                HStack{
                    Spacer()
                    Text("Цена: \(product.price)")
                        .padding()
                }
            }
            Spacer()
        }
        .frame(height: UIScreen.screenHeight / 6)
        .padding()
    }
}
