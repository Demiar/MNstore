//
//  AuthView.swift
//  MNstore
//
//  Created by Алексей on 29.04.2022.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject private var authManager = AuthManager.shared
    
    var body: some View {
        NavigationView{
            if authManager.logged {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
