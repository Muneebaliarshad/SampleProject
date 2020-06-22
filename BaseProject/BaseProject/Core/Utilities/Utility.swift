//
//  Utility.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import LocalAuthentication


class Utility : NSObject {
    
    //MARK: - variables
    var progrssBar = UIProgressView()
    
    
//------------------------------------------------------------------------------------
    //MARK: - Device Methods
    final class func getAppVersion() -> String{
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion ?? "1.2"
    }
    
    final class func deviceUUID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    
    final class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
    final class func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    //MARK:- Time Conversion Methods
    // Get Formatted Hours : Minutes : Seconds from Integer
    final class func GetHMSFrom(seconds: Int) -> String {
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return String(format:"%02i : %02i", hours , mins, sec)
    }
    
    // Get Formatted  Minutes : Seconds from Integer
    final class func GetMSFrom(seconds: Int) -> String {
        let hours = seconds / 3600
        let mins = (hours * 60) + ((seconds % 3600) / 60)
        let sec = (seconds % 3600) % 60
        return String(format:"%02i : %02i", mins, sec)
    }
    
    
//------------------------------------------------------------------------------------
    //MARK: - UIView Helping Methods
    final class func getTopViewController() -> UIViewController {
        var finalViewController = UIViewController()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            finalViewController = topController
        }
        return finalViewController
    }
    
    
//------------------------------------------------------------------------------------
    //MARK: - Jason Methods
    final class func decode<T: Decodable>(data: Data, ofType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let res = try decoder.decode(APIResponseModel<T>.self, from: data)
            return res.respData
        } catch let parsingError {
            Utility.printData("🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ Json Mapping Error : 🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ " + parsingError.localizedDescription)
        }
        return nil
    }
    
    
    final class func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    final class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
//------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    final class func printData(_ object: Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
    
    
    final class func shareData(_ stringURL: String = kWebsite, _ image: UIImage, _ text: String = "") {
        let myWebsite = NSURL(string: stringURL)
        guard let url = myWebsite else {
            Utility.printData("nothing found")
            return
        }
        
        let shareItems:Array = [url] as [Any]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems as [Any], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        getTopViewController().present(activityViewController, animated: true, completion: nil)
    }
    
    
    final class func authenticateUser(completionHandler: @escaping (_ sucess: Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in
                if success {
                    completionHandler(success)
                } else {
                    showAlert(isSucess: false, "Authentication failed", authenticationError?.localizedDescription ?? "")
                }
            }
        } else {
            showAlert(isSucess: false, "Touch ID not available", "Your device is not configured for Touch ID.")
        }
    }
    
//------------------------------------------------------------------------------------
    //MARK: - Alert Methods
    final class func showAlert(isSucess: Bool, _ title: String, _ message: String)  {
        let topVC = getTopViewController()
        let frame = CGRect(x: 0, y: 0 , width: topVC.view.frame.width, height: topVC.view.frame.height)
        let alertView = AlertView(frame: frame)
        alertView.setAlertWithMessage(isSucess: isSucess, title: title, message: message)
        topVC.view.addSubview(alertView)
        topVC.view.bringSubviewToFront(alertView)
    }
    
    
    final class func showAlertWithSingleButton( isSucess: Bool, _ title: String, _ message: String, _ positiveButtontitle: String)  {
        let topVC = getTopViewController()
        let frame = CGRect(x: 0, y: 0 , width: topVC.view.frame.width, height: topVC.view.frame.height)
        let alertView = AlertView(frame: frame)
        alertView.setAlertWithSingleButton(isSucess: isSucess, title: title, message: message, positiveButtontitle: positiveButtontitle)
        topVC.view.addSubview(alertView)
        topVC.view.bringSubviewToFront(alertView)
    }
    
    final class func showAlertWithTwoButton( isSucess: Bool, title: String, message: String, positiveButtontitle: String,  negitiveButtonTitle: String) -> AlertView {
        let topVC = getTopViewController()
        let frame = CGRect(x: 0, y: 0 , width: topVC.view.frame.width, height: topVC.view.frame.height)
        let alertView = AlertView(frame: frame)
        alertView.setAlert(isSucess: isSucess, title: title, message: message, positiveButtontitle: positiveButtontitle, negitiveButtontitle: negitiveButtonTitle)
        topVC.view.addSubview(alertView)
        topVC.view.bringSubviewToFront(alertView)
        return alertView
    }
}
