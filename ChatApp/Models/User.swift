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
    
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
    }
    
}
