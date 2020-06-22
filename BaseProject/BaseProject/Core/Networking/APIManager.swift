//
//  APIManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Alamofire


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
