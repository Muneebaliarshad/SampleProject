//
//  UserDefaultManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation


final class UserDefaultsManager: NSObject {
    
    //MARK: - Variables
    
    
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - User Data
    final class func setUserModel(user: UserModel){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeyString.UserData)
        }
    }
    
    class func getUserModel() -> UserModel {
        if let savedUser = UserDefaults.standard.object(forKey: UserDefaultsKeyString.UserData) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserModel.self, from: savedUser) {
                return loadedUser
            }
        }
        return UserModel()
    }
    
    
    class func isUserLogin() -> Bool {
        let userData = getUserModel()
        if userData.email != nil {
            return true
        }
        
        if userData.msisdn != nil {
            return true
        }
        
        return false
    }
    
    
    //----------------------------------------------------------------------------------------------------
    //MARK: - APNS Token
    final class func saveAPNSToken( _ token: Data, _ tokenString: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKeyString.DeviceToken)
        UserDefaults.standard.set(tokenString, forKey: UserDefaultsKeyString.APNSToken)
    }
    
}
