//
//  ConfirmOrder.swift
//  MNstore
//
//  Created by Алексей on 21.04.2022.
//

import SwiftUI

struct ConfirmOrder: View {
    var body: some View {
        Form{
            Text("Оформление заказа")
            VStack{
                Text("Способ Оплаты")
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("")) {
                    Text("Наличными при получении")
                        .tag(1)
                    Text("YooKassa")
                        .tag(2)
                }
            }
            VStack{
                Text("Способ Доставки")
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("")) {
                    Text("Курьер")
                        .tag(1)
                    Text("PickPoint")
                        .tag(2)
                }
                .pickerStyle(.menu)
            }
            VStack{
                Text("Данные покупателя")
                TextField("Имя", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                TextField("Фамилия", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                TextField("Электронная почта", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                TextField("Номер телефона", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Spacer()
                Button(action: {}, label: {
                    Text("Оформить заказ")
                        .foregroundColor(.red)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.red, lineWidth: 2)
                        )
                })
                Spacer()
            }
 
        }
    }
}

struct ConfirmOrder_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOrder()
    }
}
