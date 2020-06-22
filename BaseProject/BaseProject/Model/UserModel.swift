//
//  UserModel.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import Alamofire


//MARK: - Model

struct UserModel: Codable {
    var userId: String?
    var email: String?
}


//MARK: - API
struct RegistrationAPIs {

    static func signInAPI(userName: String, password: String, completionHandler: @escaping (_ message: String?, _ isSucess: Bool) -> Void) {
        
        if !(Utility.isConnectedToInternet())  {
            completionHandler(ApiErrorMessage.NoNetwork, false)
            return
        }

        let successClosure: DefaultArrayResultAPISuccessClosure = {
            (result) in
            do {
                let jsonData = Utility.json(from: result)
                let jsonDecoder = JSONDecoder()
                let dataSource = try jsonDecoder.decode(APIResponseModel<UserModel>.self, from: (jsonData?.data(using: .utf8)!)!)
                completionHandler(dataSource.msg, dataSource.isSuccess ?? false)
            }
            catch {
                completionHandler(ApiErrorMessage.ErrorOccured, false)
                print("🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ Json Mapping Error : 🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ " + error.localizedDescription)
            }
        }
        let failureClosure: DefaultAPIFailureClosure = {_ in
            completionHandler(ApiErrorMessage.ErrorOccured, false)
        }

        let params = ["username": userName,
                      "password": password,
                      "requestSource": "app"]

        APIManager.sharedInstance.authenticationManagerAPI.signin(parameters: params , type:HTTPMethod.post , success: successClosure, failure: failureClosure)
    }
}

