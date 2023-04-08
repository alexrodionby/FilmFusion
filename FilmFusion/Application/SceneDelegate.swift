//
//  SceneDelegate.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

@available(iOS 15.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let tabBarController = AuthVC()
      //  let tabBarController = TabBarVC()
        //let DetailVC = UINavigationController(rootViewController: DetailVC())
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: tabBarController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
