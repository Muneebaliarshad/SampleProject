//
//  UserModel.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation
import Alamofire


//MARK: - Model
struct APIResponse<T: Decodable>: Decodable {
    var isSuccess: Bool?
    var msg: String?
    var respCode: String?
    var respData: T?
}




struct UserModel: Codable {
    var userId: String?
    var email: String?
    var msisdn: String?
    var status: Int?
    var pkgplan: Int?
    var suspended: Int?
    var subFrom: String?
    var dateExpiry: String?
    
    enum CodingKeys: String, CodingKey {
        case userId, email, msisdn, pkgplan, dateExpiry, subFrom
        case status, suspended
    }
}


//MARK: - API
struct RegistrationAPIs {
    
    static func loginUser(userName: String, password: String, completionHandler: @escaping (_ message: String?, _ isSucess: Bool) -> Void) {
        
        if !(Utility.isConnectedToInternet())  {
            completionHandler(ApiErrorMessage.NoNetwork, false)
            return
        }
        
        let successClosure: DefaultArrayResultAPISuccessClosure = { (result) in
            do {
                let jsonData = Utility.json(from: result)
                let jsonDecoder = JSONDecoder()
                let dataSource = try jsonDecoder.decode(APIResponse<UserModel>.self, from: (jsonData?.data(using: .utf8)!)!)
                
                if dataSource.isSuccess ?? false {
                    UserDefaultsManager.setUserModel(user: dataSource.respData!)
                }
                
                
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
        
        let params = [APIKeys.UserName: userName,
                      APIKeys.Password: password]
        
        APIManager.sharedInstance.authenticationManagerAPI.verifyPin(parameters: params , type:HTTPMethod.post , success: successClosure, failure: failureClosure)
    }

    
}
