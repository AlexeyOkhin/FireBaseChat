//
//  ChatViewController.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var chatTableView: UITableView!

    var messages = [Message]()
    let dbMessage = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.allowsSelection = false
        chatTableView.estimatedRowHeight = 100
        chatTableView.register(UINib(nibName: "MessageViewCell", bundle: nil),
                               forCellReuseIdentifier: MessageViewCell.identifier)
        getData()
        configureNavigation()
    }

    private func configureNavigation() {
        title = "⚡️FireChat"
        navigationItem.hidesBackButton = true
        let barRightItem = UIBarButtonItem(title: "LogOut",
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapLogout))
       navigationItem.rightBarButtonItem = barRightItem
    }

    private func getData() {

        dbMessage.collection("messages").order(by: "date").addSnapshotListener { [weak self](querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self?.messages = []
                for document in querySnapshot!.documents {

                    guard let body = document.data()["body"] as? String else { return }
                    guard let sender = document.data()["sender"] as? String else { return }
                    let message = Message(body: body, avatar: UIImage(named: "MeAvatar"), sender: sender)
                    self?.messages.append(message)
                    DispatchQueue.main.async {
                        self?.chatTableView.reloadData()
                        let indexPath = IndexPath(row: (self?.messages.count ?? 1) - 1, section: 0)
                        self?.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }

                }
            }
        }
    }

    @IBAction func sendActionButton(_ sender: UIButton) {
        guard let body = messageTF.text, let sender = Auth.auth().currentUser?.email else { return }
        let date = Date().timeIntervalSince1970
        dbMessage.collection("messages").document().setData(["body": body, "sender": sender, "date": date]) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error", message: "\(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.messageTF.text = nil
                }

            }
        }
    }

    @objc
    private func didTapLogout() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            showAlert(title: "Внимание", message: "\(signOutError)")
        }

    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageViewCell.identifier, for: indexPath)
                as? MessageViewCell
                else { return UITableViewCell() }
        
        let model = messages[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}
