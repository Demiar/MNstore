//
//  CartView.swift
//  MNstore
//
//  Created by Алексей on 17.04.2022.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var productCartManager = ProductCartManager.shared
    
    var body: some View {
            NavigationView{
                if productCartManager.cartEmpty {
                    Text("Нет товаров в корзине!")
                } else {
                    VStack{
                        List{
                            ForEach($productCartManager.products) { $product in
                                HStack{
                                    ZStack(alignment: .leading){
                                        NavigationLink(destination: {
                                            //ProductViewDetail(product: product)
                                        }){
                                        }
                                        .opacity(0)
                                        CartViewCell(productCart: $product)
                                    }

                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 12, alignment: .leading)
                            }


                        }
                        Text("Сумма заказа: \(String(format: "%.2f", productCartManager.sumCart()))")
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
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Корзина")
                }

        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
