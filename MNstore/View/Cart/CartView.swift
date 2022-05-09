//
//  CartView.swift
//  MNstore
//
//  Created by Алексей on 17.04.2022.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var itemsCart = ItemsCart.shared
    
    var body: some View {
            NavigationView{
                VStack{
                    List{//($itemsCart.itemsCart){ $item in
                        if $itemsCart.itemsCart.isEmpty {
                            Text("Нет товаров в корзине!")
                        } else {
                            ForEach($itemsCart.itemsCart) { $item in
                                HStack{
                                    ZStack(alignment: .leading){
                                        NavigationLink(destination: {
                                            ProductViewDetail(product: item.product)
                                        }){
                                        }
                                        .opacity(0)
                                        CartViewCell(productCart: $item)
                                    }

                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 12, alignment: .leading)
                            }

                        }

                    }
                    if !$itemsCart.itemsCart.isEmpty {
                        Text("Сумма заказа: \(itemsCart.sumCart(), specifier: "%.2f")")
                            .padding()
                        NavigationLink(destination: {ConfirmOrder()},
                                       label: {
                                            Text("Оформить заказ")
                                                .foregroundColor(.red)
                                                .padding(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 2)
                                                        .stroke(Color.red, lineWidth: 2)
                                                )
                                        }
                        )

                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Корзина")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
