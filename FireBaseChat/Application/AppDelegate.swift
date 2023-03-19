//
//  AppDelegate.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let navigationVC = UINavigationController(rootViewController: mainVC)
        navigationVC.navigationBar.tintColor = .white
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }

}
