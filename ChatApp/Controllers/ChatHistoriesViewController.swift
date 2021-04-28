//
//  ChatHistoriesViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/25.
//

import UIKit

final class ChatHistoriesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationController()
        presentSignUpVC()
        
        let rightBarButton = UIBarButtonItem(title: "新規チャット",
                                             style: .plain,
                                             target: self,
                                             action: #selector(rightBarButtonDidTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        fetchUserInfoFromFirestore()
        
    }
    
}

// MARK: - Firebase
private extension ChatHistoriesViewController {
    
    func fetchUserInfoFromFirestore() {
        FirebaseAPI.shared.fetchUserInfo { result in
            switch result {
                case .success(let user):
                    self.users.append(user)
                    self.tableView.reloadData()
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }
    
}

// MARK: - setup
private extension ChatHistoriesViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .rgb(red: 39, green: 49, blue: 69)
        navigationItem.title = "トーク"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func presentSignUpVC() {
        if FirebaseAPI.shared.isLogged {
            let signUpVC = UIStoryboard.signUp.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
            signUpVC.modalPresentationStyle = .fullScreen
            self.present(signUpVC, animated: true, completion: nil)
        }
    }
    
}

// MARK: - @objc func
@objc private extension ChatHistoriesViewController {
    
    func rightBarButtonDidTapped() {
        let userHistoriesVC = UIStoryboard.userHistories.instantiateViewController(identifier: UserHistoriesViewController.identifier) as! UserHistoriesViewController
        let navigationC = UINavigationController(rootViewController: userHistoriesVC)
        present(navigationC, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate
extension ChatHistoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = UIStoryboard.chatRoom.instantiateViewController(identifier: ChatRoomViewController.identifier)
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension ChatHistoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier,
                                                 for: indexPath) as! ChatTableViewCell
        let user = users[indexPath.row]
        cell.setup(user: user)
        return cell
    }
    
}

