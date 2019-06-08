//
//  APIManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

typealias DefaultAPIFailureClosure = (NSError) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias DefaultStringResultAPISuccessClosure = (String) -> Void


protocol APIErrorHandler {
    func handleErrorFromResponse(response: Dictionary<String,AnyObject>)
    func handleErrorFromERror(error:NSError)
}


final class APIManager: NSObject {
    static let sharedInstance = APIManager()
    var serverToken: String? {
        get{
            return ""
        }
        set{
        }
        
    }
    let authenticationManagerAPI = AuthenticationAPIManager()
}
