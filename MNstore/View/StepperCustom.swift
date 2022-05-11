//
//  StepperCustom.swift
//  MNstore
//
//  Created by Алексей on 20.04.2022.
//

import SwiftUI

struct StepperCustom: View {
    @Binding var value: Int
    var step: Int = 1
    var maximum: Int = 100
    let product: Product?
    var productId: Int = 0
    var price: Int = 0
    
    var body: some View {
        HStack{
            Button(action: {
                if value > 1 {
                    value -= step
                } else {
                    ProductCartManager.shared.deleteCart(productId: productId, quantity: value)
                }
            }, label: {
                Image(systemName: "minus")
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.red, lineWidth: 2)
                    )
            })
            .buttonStyle(BorderlessButtonStyle())
            Text("\(value)")
                .font(.system(size: 14))
                .frame(width: 30)
            Button(action: {
                if value < product?.quantity ?? maximum {
                    value += step
                }
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.red, lineWidth: 2)
                    )
            })
            .buttonStyle(BorderlessButtonStyle())
            
        }
        .frame(width: 90, height: 30, alignment: .leading)
    }
}

