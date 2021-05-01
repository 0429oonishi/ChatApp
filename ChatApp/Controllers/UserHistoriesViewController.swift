//
//  UserHistoriesViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

final class UserHistoriesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
}

// MARK: - setup UITableView
private extension UserHistoriesViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.nib,
                           forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
}

// MARK: - UITableViewDelegate
extension UserHistoriesViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension UserHistoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.setup(user: user)
        return cell
    }
    
}
