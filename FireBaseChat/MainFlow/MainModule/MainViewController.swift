//
//  MainViewController.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    private let titleText = "⚡️FireChat"

    override func viewDidLoad() {
        super.viewDidLoad()
        animationTitle()
    }

    private func animationTitle() {
        var animationDuration = 0.0
        titleText.forEach { char in
            Timer.scheduledTimer(withTimeInterval: 0.1 * animationDuration, repeats: false) { timer in
                self.titleLabel.text?.append(char)
            }
            animationDuration += 1
        }
    }


    @IBAction func enterButton(_ sender: UIButton) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginVC, animated: true)

    }

    @IBAction func registerButton(_ sender: Any) {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(registerVC, animated: true)

    }
}

