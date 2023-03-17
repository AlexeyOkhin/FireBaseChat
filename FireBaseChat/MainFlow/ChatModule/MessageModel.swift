//
//  MessageModel.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 17.03.2023.
//

import UIKit

struct Message {
    let body: String
    let avatar: UIImage?
}

#if DEBUG
extension Message {
    static let createMessages = [
        Message(body: "Hello", avatar: UIImage(named: "MeAvatar")),
        Message(body: "What up", avatar: UIImage(named: "MeAvatar")),
        Message(body: "Good", avatar: UIImage(named: "MeAvatar")),
        Message(body: "Frintupin ", avatar: UIImage(named: "MeAvatar")),
        Message(body: "adfre", avatar: UIImage(named: "MeAvatar")),
        Message(body: "Hello", avatar: UIImage(named: "MeAvatar"))
    ]
}
#endif
