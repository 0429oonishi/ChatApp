//
//  UserRepository.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

typealias ResultHandler<R> = (Result<R, Error>) -> Void

protocol UserRepository: AnyObject {
    func create(password: String, userData: UserData, handler: @escaping ResultHandler<Any?>)
    func save(uid: String, userData: UserData, handler: @escaping ResultHandler<Any?>)
    func saveImage(image: UIImage, handler: @escaping ResultHandler<String>)
    func fetch(handler: @escaping ResultHandler<User>)
    var isLogged: Bool { get }
}

