//
//  UserDataStore.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/05/04.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserDataStore: UserRepository {
    
    func create(password: String, userData: UserData, handler: @escaping ResultHandler<Any?>) {
        Auth.auth().createUser(withEmail: userData.email, password: password) { result, error in
            if error != nil {
                handler(.failure(FirebaseError.Auth.create))
                return
            }
            guard let uid = result?.user.uid else {
                handler(.failure(FirebaseError.Auth.uid))
                return
            }
            self.save(uid: uid, userData: userData, handler: handler)
        }
    }
    
    func save(uid: String, userData: UserData, handler: @escaping ResultHandler<Any?>) {
        let userData = [
            "email": userData.email,
            "username": userData.username,
            "createdAt": Timestamp(),
            "profileImageUrl": userData.profileImageUrl,
        ] as [String: Any]
        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
            if error != nil {
                handler(.failure(FirebaseError.Firestore.save))
                return
            }
            handler(.success(nil))
        }
    }
    
    func saveImage(image: UIImage, handler: @escaping ResultHandler<String>) {
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else {
            handler(.failure(ImageError.convertJpeg))
            return
        }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
        storageRef.putData(uploadImage, metadata: nil) { data, error in
            if error != nil {
                handler(.failure(FirebaseError.Storage.upload))
                return
            }
            storageRef.downloadURL { url, error in
                if error != nil {
                    handler(.failure(FirebaseError.Storage.download))
                    return
                }
                guard let urlString = url?.absoluteString else {
                    handler(.failure(ImageError.convertUrlToString))
                    return
                }
                handler(.success(urlString))
            }
        }
    }
    
    func fetch(handler: @escaping ResultHandler<User>) {
        Firestore.firestore().collection("users").getDocuments { snapshots, error in
            if error != nil {
                handler(.failure(FirebaseError.Firestore.fetch))
                return
            }
            snapshots?.documents.forEach { snapshot in
                let dic = snapshot.data()
                guard let user = User(dic: dic) else {
                    handler(.failure(UserError.userInit))
                    return
                }
                handler(.success(user))
            }
        }
    }
    
    var isLogged: Bool { Auth.auth().currentUser?.uid == nil }
    
}
