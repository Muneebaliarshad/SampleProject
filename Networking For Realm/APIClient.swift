//
//  APIClient.swift
//  BaseProject
//
//  Created by Muneeb Ali on 29/05/2018.
//  Copyright © 2018 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Realm
import RealmSwift


let APIClientDefaultTimeOut = 30.0

let kRequestHeaders : [String : String] = ["deviceID": Utility.deviceUUID(), "Content-Type": "application/json", "UserAgent": "iPhone"]

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class APIClient: APIClientHandler {
    
    
    static var sharedClient: APIClient = {
        
        let baseURL = URL(string: Constants.BaseURL)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIClientDefaultTimeOut
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        
        // Configure the trust policy manager
        
        //----------------------------------------------------------With SSL Pining----------------------------------------------------------
        //        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
        //            certificates: ServerTrustPolicy.certificates(),
        //            validateCertificateChain: true,
        //            validateHost: true
        //        )
        
        //----------------------------------------------------------With Public key----------------------------------------------------------
        //        let serverTrustPolicy = ServerTrustPolicy.pinPublicKeys(
        //            publicKeys: ServerTrustPolicy.publicKeys(),
        //            validateCertificateChain: true,
        //            validateHost: true)
        
        //----------------------------------------------------------With out SSL Pining----------------------------------------------------------
        let serverTrustPolicy = ServerTrustPolicy.disableEvaluation
        
        //---------------------------------------------------------------------------------------------------------------------------------------
        
        
        let serverTrustPolicies = [baseURL?.host ?? "": serverTrustPolicy]
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
        
        // Configure session manager with trust policy
        let instance = APIClient (
            baseURL: baseURL!,
            configuration: configuration,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
        
        // SessionManager instance.
        return instance
    }()

    //For Making Get Url 
    func GETURLfor(route:String, parameters: Parameters) -> URL?{
        var queryParameters = ""
        for key in parameters.keys {
            if queryParameters.isEmpty {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)

        }
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route+queryParameters)){
            return components.url! as URL
        }
        return nil
    }
    
    // MARK: -  < APIs WITHOUT TOKEN START >
    
    // MARK: - verifyAppVersion Request
    
    //    func verifyAppVersion(_ completionBlock: @escaping MBAPIClientCompletionHandler) -> Request {
    //
    //        let serviceName = "generalservices/verifyappversion"
    //
    //        var headers : [String : String] = kRequestHeaders
    //        headers.updateValue(MBLanguageManager.userSelectedLanguage().rawValue, forKey: "lang")
    //
    //        let params = ["appversion": String.appVersion()]
    //
    //        return sendRequest(serviceName, parameters: params as [String : AnyObject] , isPostRequest: true, headers: headers, completionBlock: completionBlock)
    //    }
    
    
}


