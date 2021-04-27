//
//  FirebaseAPI.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/27.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

typealias ResultHandler<R> = (Result<R, Error>) -> Void

final class FirebaseAPI {
    
    static let shared = FirebaseAPI()
    private init() { }
    
    func saveUserImage(image: UIImage, handler: @escaping ResultHandler<String>) {
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else { return }
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
                guard let urlString = url?.absoluteString else { return }
                handler(.success(urlString))
            }
        }
    }
        
    func createUser(email: String, password: String, username: String, profileImageUrl: String, handler: @escaping ResultHandler<Any?>) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                handler(.failure(FirebaseError.Auth.create))
                return
            }
            guard let uid = result?.user.uid else { return }
            let docData = [
                "email": email,
                "username": username,
                "createdAt": Timestamp(),
                "profileImageUrl": profileImageUrl,
            ] as [String: Any]
            self.saveUserInfo(uid: uid, docData: docData, handler: handler)
        }
    }
    
    private func saveUserInfo(uid: String, docData: [String: Any], handler: @escaping ResultHandler<Any?>) {
        Firestore.firestore().collection("users").document(uid).setData(docData) { error in
            if error != nil {
                handler(.failure(FirebaseError.Firestore.save))
                return
            }
            handler(.success(nil))
        }
    }
    
    func fetchUserInfo(handler: @escaping ResultHandler<User>) {
        Firestore.firestore().collection("users").getDocuments { snapshots, error in
            if error != nil {
                handler(.failure(FirebaseError.Firestore.fetch))
                return
            }
            snapshots?.documents.forEach { snapshot in
                let dic = snapshot.data()
                let user = User(dic: dic)
                handler(.success(user))
            }
        }
    }
    
    var isAreadySingUp: Bool { Auth.auth().currentUser?.uid == nil }
    
}
