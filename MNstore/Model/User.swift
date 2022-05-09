//
//  User.swift
//  MNstore
//
//  Created by Алексей on 29.04.2022.
//

import Foundation

struct User {
    let id: String
    let login: String
    let password: String
    let authorized: Bool = false
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case login = "LOGIN"
        case password = "PASSWORD"
        case authorized
    }
}

extension User: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        login = try values.decode(String.self, forKey: .login)
        password = try values.decode(String.self, forKey: .password)
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(password, forKey: .password)
    }
}
