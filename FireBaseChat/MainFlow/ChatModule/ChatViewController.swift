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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "⚡️FireChat"
        // configureNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // configureNavigation()
        print("willApear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigation()
        print("didAppear")
    }

    private func configureNavigation() {
       
        // title = "⚡️FireChat"

        let barRightItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(didTapLogout))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barRightItem
    }

    @IBAction func sendActionButton(_ sender: UIButton) {
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
