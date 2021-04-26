//
//  ChatRoomTableViewCell.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/25.
//

import UIKit

final class ChatRoomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        messageTextView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

// MARK: - setup
extension ChatRoomTableViewCell {
    
    func setup(text: String) {
        messageTextView.text = text
    }
    
}
