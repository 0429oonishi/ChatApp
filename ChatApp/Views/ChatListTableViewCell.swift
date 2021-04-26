//
//  ChatListTableViewCell.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/26.
//

import UIKit

final class ChatListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var latestMessageLabel: UILabel!
    @IBOutlet private weak var partnerLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
    }
    
}

// MARK: - setup
extension ChatListTableViewCell {
    
    func setup(user: User) {
        partnerLabel.text = user.username
//        userImageView.image = user.profileImageUrl
        dateLabel.text = dateFormatterForDateLabel(date: user.createdAt.dateValue())
        latestMessageLabel.text = user.email
    }
    
}

private extension ChatListTableViewCell {
    
    func dateFormatterForDateLabel(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
    
}
