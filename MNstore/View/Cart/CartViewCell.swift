//
//  CartViewCell.swift
//  MNstore
//
//  Created by Алексей on 28.04.2022.
//

import SwiftUI

struct CartViewCell: View {
    @Binding var productCart: ProductCart
    
    var body: some View {
        HStack{
            Image("18030")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .center){
                Text(productCart.product.name)
                    .frame(width: 300)
                    .font(.headline)
                HStack{
                    Spacer()
                    StepperCustom(value: $productCart.count, product: productCart.product)
                        .frame(alignment: .leading)
                    Spacer()
                    Text("\(productCart.price * Float(productCart.count), specifier: "%.0f") руб.")
                        .font(.system(size: 14))
                        .frame(width: 80, alignment: .trailing)
                    Spacer()
                }
            }
        }
    }
}
//
//struct CartViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CartViewCell(productCart: Binding(ProductCart(id: UUID(), product: Product(id: 1, quantity: 1, sectionID: 1, name: "123", image: "18030", price: 123), count: 123, price: 123)))
//    }
//}
