//
//  UserDefaultManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation


final class RVUserDefaultsManager: NSObject {

    //MARK: - Variables


    //MARK: - User Data
    final class func setUserModel(user: UserModel){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            DEFAULTS.set(encoded, forKey: "UserData")

        }
    }

    class func getUserModel() -> UserModel {
        if let savedUser = DEFAULTS.object(forKey: "UserData") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserModel.self, from: savedUser) {
                return loadedUser
            }
        }
        return UserModel()
    }


    class func isUserLogin() -> Bool {
        let userData = getUserModel()

        if userData.userId != nil {
            return true
        }
        return false
    }
    

    //MARK: - APNS Token
    final class func saveAPNSToken( _ token: Data, _ tokenString: String) {
        DEFAULTS.set(token, forKey: "DeviceToken")
        DEFAULTS.set(tokenString, forKey: "APNSToken")
    }
    
}
