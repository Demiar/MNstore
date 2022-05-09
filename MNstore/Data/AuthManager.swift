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
    @Published var logged: Bool
    
    private init() {
        logged = UserDefaults.standard.bool(forKey: "\(NameStrings.authorized.rawValue)")
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: "\(NameStrings.login.rawValue)")
        userDefaults.removeObject(forKey: "\(NameStrings.password.rawValue)")
        userDefaults.set(false, forKey: "\(NameStrings.authorized.rawValue)")
        logged = false
        
    }
    
    func logIn(login: String, password: String) {
        auth(login: login, password: password)
        logged = true
    }
    
    func auth(login: String, password: String) {
        let url = URL(string: "\(Constants.siteUrl)auth.php")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        let postString = "login=\(login)&password=\(password)";

        request.httpBody = postString.data(using: String.Encoding.utf8);

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    do {
                        let decodedData = try JSONDecoder().decode(User.self, from: data)
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(true, forKey: "\(NameStrings.authorized.rawValue)")
                        userDefaults.set(decodedData.login, forKey: "\(NameStrings.login.rawValue)")
                        userDefaults.set(decodedData.password, forKey: "\(NameStrings.password.rawValue)")
                    } catch {
                        print(error)
                    }

                }
        }
        task.resume()
    }
}
