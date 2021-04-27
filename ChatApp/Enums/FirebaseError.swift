//
//  FirebaseError.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/27.
//

import Foundation

enum FirebaseError {
    
    enum Storage: Error {
        case upload
        case download
    }
    
    enum Firestore: Error {
        case save
        case fetch
    }
    
    enum Auth: Error {
        case create
    }
    
}

