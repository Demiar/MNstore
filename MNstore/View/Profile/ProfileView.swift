//
//  ProfileView.swift
//  MNstore
//
//  Created by Алексей on 29.04.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        VStack{
            Text("Привет \(UserDefaults.standard.string(forKey: "login") ?? "") !")
            Button(action: {
                authManager.logOut()
            }, label: {
                Text("Выйти")
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
