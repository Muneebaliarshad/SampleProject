//
//  APIStrings.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation

struct APIKeys {
    static let UserName = "userName"
    static let Password = "Password"
}




struct ApiErrorMessage {
    
    static var NoNetwork:String {
        get {
            return "No Network".localized
        }
    }
    
    static var TimeOut:String {
        get {
            return "Connection Timeout.".localized
        }
    }
    
    static var ErrorOccured:String {
        get {
            return "An error occurred. Please try again.".localized
        }
    }
    
}
