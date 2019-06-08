//
//  String.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

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
    
    mutating func replaceFirstOccurrence(original: String, with newString: String) {
        if let range = self.range(of: original) {
            replaceSubrange(range, with: newString)
        }
    }
    
    
}
