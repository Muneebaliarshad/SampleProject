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
import ObjectMapper


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
    
    
    
    //Get Request Method Example
    
    
}


