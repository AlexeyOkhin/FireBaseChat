//
//  AppDelegate.swift
//  FireBaseChat
//
//  Created by Djinsolobzik on 16.03.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let navigationVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }

}
