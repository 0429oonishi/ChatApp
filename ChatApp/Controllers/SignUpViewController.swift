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
