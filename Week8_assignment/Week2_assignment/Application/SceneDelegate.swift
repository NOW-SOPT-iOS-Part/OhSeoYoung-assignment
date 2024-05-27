//
//  SceneDelegate.swift
//  Week2_assignment
//
//  Created by 오서영 on 2024/04/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 1.
        guard let windowScene = (scene as? UIWindowScene) else { return }
    // 2.
        self.window = UIWindow(windowScene: windowScene)
    // 3.
//        let navigationController = UINavigationController(rootViewController: ViewController())
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = navigationController
    // 4.
        self.window?.makeKeyAndVisible()
    }
}
