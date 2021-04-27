//
//  ChatListViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/25.
//

import UIKit

final class ChatListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationController()
        presentSignUpVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        fetchUserInfoFromFirestore()
        
    }
    
}

// MARK: - Firebase
private extension ChatListViewController {
    
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
private extension ChatListViewController {
    
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
        if FirebaseAPI.shared.isAreadySingUp {
            let storyboard = UIStoryboard(name: .signUp, bundle: nil)
            let signUpVC = storyboard.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
            signUpVC.modalPresentationStyle = .fullScreen
            self.present(signUpVC, animated: true, completion: nil)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: .chatRoom, bundle: nil)
        let chatRoomVC = storyboard.instantiateViewController(identifier: ChatRoomViewController.identifier)
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension ChatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier,
                                                 for: indexPath) as! ChatListTableViewCell
        let user = users[indexPath.row]
        cell.setup(user: user)
        return cell
    }
    
}

