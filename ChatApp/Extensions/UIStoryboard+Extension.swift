//
//  UIStoryboard+Extension.swift
//  ChatApp
//
//  Created by 大西玲音 on 2021/04/28.
//

import UIKit

extension UIStoryboard {
    
    static var chatList: UIStoryboard {
        UIStoryboard(name: .chatList, bundle: nil)
    }
    
    static var chatRoom: UIStoryboard {
        UIStoryboard(name: .chatRoom, bundle: nil)
    }
    
    static var signUp: UIStoryboard {
        UIStoryboard(name: .signUp, bundle: nil)
    }
    
    static var userList: UIStoryboard {
        UIStoryboard(name: .userList, bundle: nil)
    }
    
}
