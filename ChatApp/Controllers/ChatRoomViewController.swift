//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/25.
//

import UIKit

final class ChatRoomViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    static var identifier: String { String(describing: self) }
    private var chatInputAccessoryView: ChatInputAccessoryView = {
       let view = ChatInputAccessoryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        return view
    }()
    override var inputAccessoryView: UIView? { chatInputAccessoryView }
    override var canBecomeFirstResponder: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatRoomTableViewCell.nib(),
                           forCellReuseIdentifier: ChatRoomTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .rgb(red: 118, green: 140, blue: 180)
      
    }
    
}

// MARK: - UITableViewDelegate
extension ChatRoomViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    
}

// MARK: - UITableViewDataSource
extension ChatRoomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.identifier,
                                                 for: indexPath) as! ChatRoomTableViewCell
        return cell
    }
    
}

