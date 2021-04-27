//
//  UserListTableViewCell.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

final class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - setup
extension UserListTableViewCell {
    
    func setup(user: User) {
        userNameLabel.text = user.username
    }
    
}

