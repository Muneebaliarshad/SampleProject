//
//  AuthenticationAPIManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Alamofire


class AuthenticationAPIManager: APIManagerBase {
    
    //MARK: - Registration
    func signin(parameters: Parameters,
                type: HTTPMethod,
                success: @escaping DefaultAPISuccessClosure,
                failure: @escaping DefaultAPIFailureClosure){
        
        let route: URL =
            POSTURLforRoute(route: Route.Signin.rawValue)!
        serverRequestWith(route: route, parameters: parameters, requestType: type, success: success, failure: failure)
    }
}
