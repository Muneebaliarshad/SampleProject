//
//  AuthenticationAPIManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit
import Alamofire


class AuthenticationAPIManager: APIManagerBase {
    
    func verifyPin(parameters: Parameters,
                   type:HTTPMethod,
                   success:@escaping DefaultArrayResultAPISuccessClosure,
                   failure:@escaping DefaultAPIFailureClosure){
        
        let route: URL = POSTURLforRoute(route: Route.Login.rawValue)!
        self.serverRequestWith(route: route, parameters: parameters, requestType: type, success: success, failure: failure)
    }
    
}
