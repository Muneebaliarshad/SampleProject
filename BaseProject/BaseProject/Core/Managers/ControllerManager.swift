//
//  ControllerManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@available(iOS 13.0, *)
let Scene_Delegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
let App_Delegate = UIApplication.shared.delegate as! AppDelegate


class ControllerManager: NSObject {
    
    //MARK: - Variables
    
    
    //MARK: - Root Methods
    final class func setRootView(window: UIWindow?) {
        if #available(iOS 13.0, *){
            setRootAsLogin(window: window ?? Scene_Delegate.window!)
        } else {
            setRootAsLogin(window: window ?? App_Delegate.window!)
        }
    }
    
    
    final class func setRootAsLogin(window: UIWindow) {
        if RVUserDefaultsManager.isUserLogin() {
            setHomeAsRootView(window: window)
        } else {
            setLoginAsRootView(window: window)
        }
    }
    
    
    final class func setHomeAsRootView(window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarView: UITabBarController = storyboard.instantiateViewController(withIdentifier: "MainStory") as! UITabBarController
        window.rootViewController = tabBarView
        window.makeKeyAndVisible()
    }
    
    final class func setLoginAsRootView(window: UIWindow) {
        let storyboard = UIStoryboard(name: "Registration", bundle: Bundle.main)
        let landingVC = storyboard.instantiateViewController(withIdentifier: "LandingStory")
        window.rootViewController = landingVC
        window.makeKeyAndVisible()
    }
}
