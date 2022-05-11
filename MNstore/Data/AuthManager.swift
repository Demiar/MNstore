//
//  AuthManager.swift
//  MNstore
//
//  Created by Алексей on 28.04.2022.
//

import Foundation


class AuthManager: ObservableObject {
    static let shared = AuthManager()
    let userDefaults = UserDefaults.standard
    let networkManager = NetworkManager()
    @Published var logged: Bool
    @Published var message: String = ""
    
    private init() {
        logged = userDefaults.bool(forKey: "\(NameStrings.authorized.rawValue)")
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: "\(NameStrings.id.rawValue)")
        userDefaults.removeObject(forKey: "\(NameStrings.login.rawValue)")
        userDefaults.removeObject(forKey: "\(NameStrings.password.rawValue)")
        userDefaults.set(false, forKey: "\(NameStrings.authorized.rawValue)")
        logged = false
        
    }
    
    func logIn(login: String, password: String) {
        auth(login: login, password: password)
    }
    
    func getUserId() -> Int {
        var result = 0
        if logged {
            result = Int(userDefaults.integer(forKey: "\(NameStrings.id.rawValue)"))
        }
        return result
    }
    
    private func auth(login: String, password: String) {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.auth)/",
                                parameters: ["type": "auth",
                                             "login": "\(login)",
                                             "password": "\(password)",
                                             "remember": "Y"
                                            ]) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self.userDefaults.set(true, forKey: "\(NameStrings.authorized.rawValue)")
                self.userDefaults.set(user.id, forKey: "\(NameStrings.id.rawValue)")
                self.userDefaults.set(user.login, forKey: "\(NameStrings.login.rawValue)")
                self.userDefaults.set(user.password, forKey: "\(NameStrings.password.rawValue)")
                self.logged = true
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func forgotPassword(email: String) {
        networkManager.loadData(urlString: "\(Constant.siteUrl.rawValue)\(Constant.auth)/",
                                parameters: ["type": "forgotPassword",
                                             "email": "\(email)",
                                            ]) { (result: Result<String, Error>) in
            switch result {
            case .success(let success):
                print(success)
                self.message = success
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
