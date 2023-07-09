//
//  UserModel.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 08/07/2023.
//

import Foundation

struct User: Codable {
    var username: String
    var password: String
    var email: String
    var fullName: String
    
    init(username: String, password: String, email: String, fullName: String) {
        self.username = username
        self.password = password
        self.email = email
        self.fullName = fullName
    }
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
        case email = "email"
        case fullName = "fullName"
    }
}

typealias Users = [User]
