//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/26.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var profileImageButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var alreadyHaveAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonDidTapped), for: .touchUpInside)
        registerButton.isEnabled = false
        registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        registerButton.addTarget(self, action: #selector(registerButtonDidTapped), for: .touchUpInside)
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViews()
        
    }
    
}

// MARK: - setup
private extension SignUpViewController {
    
    func setupViews() {
        profileImageButton.backgroundColor = .white
        profileImageButton.layer.cornerRadius = profileImageButton.frame.size.width / 2
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240).cgColor
        registerButton.layer.cornerRadius = 10
    }
    
}

// MARK: - @objc func
@objc private extension SignUpViewController {
    
    func profileImageButtonDidTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func registerButtonDidTapped() {
        saveUserImageToFirestorage()
    }
    
}

// MARK: - Firebase
private extension SignUpViewController {
    
    func saveUserImageToFirestorage() {
        guard let image = profileImageButton.imageView?.image else { return }
        FirebaseAPI.shared.saveUserImage(image: image) { result in
            switch result {
                case .success(let urlString):
                    self.saveUserInfoToFirestore(profileImageUrl: urlString)
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }
    
    func saveUserInfoToFirestore(profileImageUrl: String) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = self.usernameTextField.text else { return }
        FirebaseAPI.shared.createUser(email: email,
                                      password: password,
                                      username: username,
                                      profileImageUrl: profileImageUrl) { result in
            switch result {
                case .success:
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }
        
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let emailIsEmpty = emailTextField.text?.isEmpty,
              let passwordIsEmpty = passwordTextField.text?.isEmpty,
              let usernameIsEmpty = usernameTextField.text?.isEmpty else { return }
        if emailIsEmpty || passwordIsEmpty || usernameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemOrange
        }
    }
    
}


// MARK: - UIImagePickerControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        profileImageButton.setTitle("", for: .normal)
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension SignUpViewController: UINavigationControllerDelegate {
    
}
