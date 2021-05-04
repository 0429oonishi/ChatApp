//
//  UserUsecase.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

class UserUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository = UserDataStore()) {
        self.repository = repository
    }
    
    func save(uid: String, userData: UserData, handler: @escaping ResultHandler<Any?>) {
        repository.save(uid: uid, userData: userData, handler: handler)
    }
    
    func saveImage(image: UIImage, handler: @escaping ResultHandler<String>) {
        repository.saveImage(image: image, handler: handler)
    }
    
    func create(password: String, userData: UserData, handler: @escaping ResultHandler<Any?>) {
        repository.create(password: password, userData: userData, handler: handler)
    }
    
    func fetch(handler: @escaping ResultHandler<User>) {
        repository.fetch(handler: handler)
    }
    
    var isLogged: Bool { repository.isLogged }
    
}
