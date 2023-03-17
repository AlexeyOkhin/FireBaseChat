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
        navigationItem.hidesBackButton = true
        title = "⚡️FireChat"
        chatTableView.dataSource = self
        chatTableView.estimatedRowHeight = 100
        chatTableView.register(UINib(nibName: "MessageViewCell", bundle: nil),
                               forCellReuseIdentifier: MessageViewCell.identifier)
        getData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation()
        print("didAppear")
    }

    private func configureNavigation() {
        // title = "⚡️FireChat"
        let barRightItem = UIBarButtonItem(title: "LogOut",
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapLogout))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barRightItem
    }

    private func getData() {

        dbMessage.collection("messages").addSnapshotListener { [weak self](querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self?.messages = []
                for document in querySnapshot!.documents {

                    guard let body = document.data()["body"] as? String else { return }
                    let sender = document.data()["sender"]
                    let message = Message(body: body, avatar: UIImage(named: "MeAvatar"))
                    self?.messages.append(message)
                    DispatchQueue.main.async {
                        self?.chatTableView.reloadData()
                    }

                }
            }
        }
    }

    @IBAction func sendActionButton(_ sender: UIButton) {
        guard let body = messageTF.text, let sender = Auth.auth().currentUser?.email else { return }

        dbMessage.collection("messages").document().setData(["body": body, "sender": sender]) { error in
            if let error = error {
                self.showAlert(title: "Error", message: "\(error.localizedDescription)")
            } else {
                print("Success setMessage")
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
