//
//  String.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation


extension String {
    
    //MARK: - Variables
    var length: Int {
        return self.count
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    //MARK: - Functions
    func fromBase64() -> String {
        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: String.Encoding.utf8)!
    }
    
    
    func toBase64() -> String {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    func createURL() -> URL{
        let urlString  = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if let url = URL(string: urlString){
            return url
        }
        return  URL(string: "urlString")!
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let result =  emailPredicate.evaluate(with: self)
        return result
    }
    
    func isValidPhoneNum() -> Bool {
        let PHONE_REGEX = "^[0-9]{6,15}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func isValidName() -> Bool{
        let NAME_REGEX = "(?<! )[-a-zA-Z' ]{2,26}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", NAME_REGEX)
        let result =  nameTest.evaluate(with: self)
        return result
        
    }
    
    func isValidPassword() -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        
        if rangeOfCharacter(from: characterset.inverted) != nil && length >= 8 {
            return true
            
        } else {
            return false
        }
    }
    
    mutating func replaceFirstOccurrence(original: String, with newString: String) {
        if let range = self.range(of: original) {
            replaceSubrange(range, with: newString)
        }
    }
}
