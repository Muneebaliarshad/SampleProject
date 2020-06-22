//
//  APIStrings.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation

// MARK: - ApiErrorMessage
struct ApiErrorMessage {

    static var NoNetwork:String {
        get {
            return "No Network".localized
        }
    }

    static var ErrorOccured:String {
        get {
            return "Error Occured \(TryAgain)".localized
        }
    }
    
    static var TryAgain:String {
        get {
            return "Please Try Again. Thankyou.".localized
        }
    }

}
