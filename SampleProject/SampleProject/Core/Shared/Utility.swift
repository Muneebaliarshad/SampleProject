//
//  Utility.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation
import UIKit
import FCAlertView
import Alamofire
import NVActivityIndicatorView



class Utility : NSObject {
    
    //MARK: - variables
    
    
    final class func deviceUUID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    final class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    final class func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
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
    
    final class func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    final class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    
//----------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    final class func shareData(_ text: String = "", _ stringURL: String = "", _ image: UIImage = #imageLiteral(resourceName: "Logo")) {
        let myWebsite = NSURL(string: stringURL)
        guard let url = myWebsite else {
            print("nothing found")
            return
        }
        
        let shareItems:Array = [image, text, url] as [Any]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems as [Any], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        Utility.getTopViewController().present(activityViewController, animated: true, completion: nil)
    }

    
//----------------------------------------------------------------------------------------------------
    //MARK: - Alert Methods
    class func showTopAlert(message:String,bgColor:UIColor,textColor:UIColor = UIColor.white) {
        let popup = MessageView()
        popup.setMessageView(message: message, backgroundColor: bgColor, textColor: textColor)
    }
    
    final class func showErrorWith(message: String){
        let backgroundColor = UIColor.red
        let textColor = UIColor.white
        showTopAlert(message: message,bgColor: backgroundColor,textColor: textColor)
    }
    
    final class func showSucessWith(message: String){
        let backgroundColor = UIColor.green
        let textColor = UIColor.white
        showTopAlert(message: message,bgColor: backgroundColor,textColor: textColor)
    }
    
    final class func showInfoWith(message: String){
        let backgroundColor = UIColor.lightGray
        let textColor = UIColor.black
        showTopAlert(message: message,bgColor: backgroundColor,textColor: textColor)
    }
    
}
