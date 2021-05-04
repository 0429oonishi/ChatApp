//
//  User.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/26.
//

import Foundation
import FirebaseFirestore

struct User {
    
    let email: String
    let username: String
    let createdAt: Timestamp
    let profileImageUrl: String
    
    init?(dic: [String: Any]) {
        guard let email = dic["email"] as? String,
              let username = dic["username"] as? String,
              let createdAt = dic["createdAt"] as? Timestamp,
              let profileImageUrl = dic["profileImageUrl"] as? String else { return nil }
        self.email = email
        self.username = username
        self.createdAt = createdAt
        self.profileImageUrl = profileImageUrl
    }
    
}

struct UserData {
    let email: String
    let username: String
    let profileImageUrl: String
}
