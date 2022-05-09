//
//  ProductCardView.swift
//  MNstore
//
//  Created by Алексей on 16.04.2022.
//

import SwiftUI

struct ProductViewDetail: View {
    let product: Product
    
    @State var quantity: Int = 1
    var price: Float = 10
    
    private let itemsCart: ItemsCart = ItemsCart.shared
    @ObservedObject private var imageLoader: ImageLoader
    

    
    init(product: Product) {
        self.product = product
        self.price = Float(product.price)
        self.quantity = 1
        self.imageLoader = ImageLoader(url: product.detailPicture)
    }
    
    var body: some View {
        VStack{
            imageLoader.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(product.name)
                .padding()
            HStack{
                Spacer()
                Text("Цена: \(price, specifier: "%.0f")")
                Spacer()
                StepperCustom(value: $quantity, product: product)
                Spacer()
                Button(action: {
                    ItemsCart.shared.addItemCart(product: product, price: price, count: quantity)
                }){
                    Image(systemName: "cart.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .foregroundColor(.red)
                        .animation(.easeInOut(duration: 5),
                                   value: 10
                        )
                }
                Spacer()
                
            }
            .padding()
            Spacer()
        }
    }
}

