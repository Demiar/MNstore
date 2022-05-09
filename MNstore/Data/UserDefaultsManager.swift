//
//  UserDefaultsManager.swift
//  MNstore
//
//  Created by Алексей on 29.04.2022.
//

import Foundation

class UserDefaultsManager {
    let userDefaults = UserDefaults.standard
}

enum NameStrings: String {
    case login
    case password
    case authorized
}
