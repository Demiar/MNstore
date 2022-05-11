//
//  ForgotPasswordView.swift
//  MNstore
//
//  Created by Алексей on 09.05.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var authManager = AuthManager.shared
    @State private var email: String = ""
    
    
    var body: some View {

        VStack{
            Text("Электронная почта")
                .font(.subheadline)
            TextField("", text: $email)
                .frame(width: 200, height: 30)
                .border(.red, width: 2)
            Button(action: {
                authManager.forgotPassword(email: email)
            }, label: {
                Text("Восстановить пароль")
            })
            .foregroundColor(.red)
            .frame(width: 200, height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.red, lineWidth: 2)
            )
            .padding()
            Text(authManager.message)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
