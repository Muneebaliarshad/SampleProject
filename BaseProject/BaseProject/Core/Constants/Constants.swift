//
//  Constants.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit


let kPrivacyPolicyURL = ""
let kTermsURL = ""
let kWebsite = ""
let kAppName = "BaseProject".localized
let kDeepLink = ""
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let DEFAULTS = UserDefaults.standard



/**
 This Struct returns Screen size.
 */
struct ScreenSize{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_CENTER = CGPoint(x: SCREEN_HEIGHT/2, y: SCREEN_WIDTH/2)
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}



/**
 This Struct returns device type based on Screen size.
 */
struct DeviceType{
    
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONEX_MAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    
    static let IS_IPAD_9_7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_10_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1112.0
    static let IS_IPAD_12_9 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_ITV = UIDevice.current.userInterfaceIdiom == .tv
}
