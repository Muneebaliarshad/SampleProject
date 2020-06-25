//
//  KeyChainManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 25/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation


class KeyChainManager {

    class func saveData(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func loadData(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
    
    
//----------------------------------------------------------------------------------
    //MARK: - Save Token
    final class func saveToken(_ token: String) -> OSStatus {
        guard let data = token.data(using: .utf8) else { return 0 }
        return saveData(key: "Token", data: data)
    }


    final class func getToken() -> String {
        if let receivedData = loadData(key: "Token") {
            return String(decoding: receivedData, as: UTF8.self)
        }
        return ""
    }
}
