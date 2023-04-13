//
//  SceneDelegate.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
        if authUser == nil {
            print("пользователь не залогинился")
            let vc = LaunchAnimationVC()
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        } else {
            print("пользователь залогинился")
            // Здесь можно взять uid текущего залогининого пользователя
            print("UID пользователя", authUser?.uid ?? "Не удалось загрузить UID залогининого пользователя")
            let vc = TabBarVC()
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        }
    }
}
