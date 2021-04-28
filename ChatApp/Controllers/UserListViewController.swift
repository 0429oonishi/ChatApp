//
//  UserListViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserListTableViewCell.nib,
                           forCellReuseIdentifier: UserListTableViewCell.identifier)
        
    }
    
}

// MARK: - Firebase
private extension UserListViewController {
    
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

// MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier, for: indexPath) as! UserListTableViewCell
        let user = users[indexPath.row]
        cell.setup(user: user)
        return cell
    }
    
}
