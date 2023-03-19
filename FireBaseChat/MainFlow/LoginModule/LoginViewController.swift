//
//  LoginViewController.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
    }

    @IBAction func loginActionButton(_ sender: UIButton) {

        guard let mail = emailTF.text, let pass = passwordTF.text else { return }
        sender.isEnabled = false
        Auth.auth().signIn(withEmail: mail, password: pass) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Внимание", message: "\(error.localizedDescription)")
                sender.isEnabled = true
            } else {
                let chatVC = ChatViewController(nibName: "ChatViewController", bundle: nil)
                self?.navigationController?.pushViewController(chatVC, animated: true)
            }
        }
    }
}
