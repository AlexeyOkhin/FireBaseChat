//
//  MessageViewCell.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 17.03.2023.
//

import UIKit
import Firebase

class MessageViewCell: UITableViewCell {

    static let identifier = "\(MessageViewCell.self)"

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var leftImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(model: Message) {
        if model.sender == Auth.auth().currentUser?.email {
            leftImage.isHidden = true
            rightImage.isHidden = false
            messageView.backgroundColor = .systemBlue
            bodyLabel.textColor = .white
            bodyLabel.text = model.body
        } else {
            leftImage.isHidden = false
            rightImage.isHidden = true
            messageView.backgroundColor = .systemPink
            bodyLabel.textColor = .black
            bodyLabel.text = model.body

        }
    }
}
