//
//  SceneDelegate.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return
            
        }
        
        window = UIWindow(windowScene: windowsScene)
        let mainViewController = SearchViewController()
//        let navController = UINavigationController(rootViewController: mainViewController)
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        
        let navigation = UINavigationController(rootViewController: mainViewController)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.andes_brand
        
        let appearance = UINavigationBar.appearance()
        appearance.standardAppearance = navBarAppearance
        appearance.compactAppearance = navBarAppearance
        appearance.scrollEdgeAppearance = navBarAppearance
        appearance.barTintColor = .white
        
        if #available(iOS 15.0, *) {
          appearance.compactScrollEdgeAppearance = navBarAppearance
        } else {
          // Fallback on earlier versions
        }
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
 
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

