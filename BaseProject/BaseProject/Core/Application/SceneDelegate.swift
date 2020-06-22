//
//  SceneDelegate.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Variables
    var window: UIWindow?


    //MARK: - Scene Delegate Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window

        setSceneDefaults()
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


//---------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    func setSceneDefaults() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        swizzleMethod(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.myLocalizedString(forKey:value:table:)))
        
        ControllerManager.setRootView(window: window)
    }
}

