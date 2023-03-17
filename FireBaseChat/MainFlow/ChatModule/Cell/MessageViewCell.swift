//
//  MessageViewCell.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 17.03.2023.
//

import UIKit

class MessageViewCell: UITableViewCell {

    static let identifier = "\(MessageViewCell.self)"

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messageView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(model: Message) {
        bodyLabel.text = model.body
        avatarImage .image = model.avatar
    }
}
