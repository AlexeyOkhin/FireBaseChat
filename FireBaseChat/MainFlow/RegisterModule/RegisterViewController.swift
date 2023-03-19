//
//  RegisterViewController.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
    }

    @IBAction func registerActionButton(_ sender: UIButton) {
        guard let mail = emailTF.text, let pass = passwordTF.text else { return }

        Auth.auth().createUser(withEmail: mail, password: pass) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Внимание", message: "\(error.localizedDescription)")
            } else {
                let chatVC = ChatViewController(nibName: "ChatViewController", bundle: nil)
                self?.navigationController?.pushViewController(chatVC, animated: true)
            }

        }
    }
}
