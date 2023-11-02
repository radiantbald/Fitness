//
//  SceneDelegate.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.bounds = windowScene.screen.bounds
        
        let rootViewController = Assembler.controllers.tabBarController
//        let rootViewController = Assembler.controllers.smsCodeApprovePageViewController
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      for urlContext in URLContexts {
          let url = urlContext.url
          Auth.auth().canHandle(url)
      }
      // URL not auth related; it should be handled separately.
    }
}

