//
//  ChatInputAccessoryView.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/26.
//

import UIKit

final class ChatInputAccessoryView: UIView {
    
    @IBOutlet private weak var chatTextView: UITextView!
    @IBOutlet private weak var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
        setupViews()
        autoresizingMask = .flexibleHeight
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize { .zero }
    
    private func loadNib() {
        let nib = UINib(nibName: String(describing: ChatInputAccessoryView.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
}

// MARK: - setup
private extension ChatInputAccessoryView {
    
    func setupViews() {
        chatTextView.layer.cornerRadius = 15
        chatTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        chatTextView.layer.borderWidth = 1
        sendButton.layer.cornerRadius = 15
        sendButton.imageView?.contentMode = .scaleAspectFill
        sendButton.contentVerticalAlignment = .fill
        sendButton.contentHorizontalAlignment = .fill
        sendButton.isEnabled = true
    }
    
}
