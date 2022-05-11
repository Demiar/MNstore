//
//  LoginView.swift
//  MNstore
//
//  Created by Алексей on 29.04.2022.
//

import SwiftUI

struct LoginView: View {
    @State var login: String = "aleksei"
    @State var password: String = "03118686"
    @State private var selection: Bool = false
    
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        VStack{
            Text("Логин")
                .font(.subheadline)
            TextField("", text: $login)
                .frame(width: 160, height: 30)
                .border(.red, width: 2)
            Text("Пароль")
                .font(.subheadline)
            TextField("", text: $password)
                .frame(width: 160, height: 30)
                .border(.red, width: 2)
            Button(action: {
                authManager.logIn(login: login, password: password)
            }, label: {
                Text("Войти")
            })
            .foregroundColor(.red)
            .frame(width: 160, height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.red, lineWidth: 2)
            )
            .padding()
            Button(action: {
                
            }, label: {
                Text("Регистрация")
            })
            .foregroundColor(.red)
            .frame(width: 160, height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.red, lineWidth: 2)
            )
            .padding()
            NavigationLink(destination: ForgotPasswordView(), isActive: $selection) {
                Button(action: {
                    self.selection = true
                }, label: {
                    Text("Забыли пароль?")
                })
                .foregroundColor(.red)
                .frame(width: 160, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.red, lineWidth: 2)
                )
                .padding()
            }

            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
