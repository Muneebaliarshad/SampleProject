//
//  ResponseHandler.swift
//  BaseProject
//
//  Created by Muneeb Ali on 29/05/2018.
//  Copyright © 2018 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class ResponseHandler: Mappable {
    
    // MARK: - Properties
    var callStatus: Bool = false
    var resultCode: String?
    var resultDesc: String?
    var exception: String?
    var data: AnyObject? // data can be nil
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        callStatus          <- (map["callStatus"],transform)
        resultCode          <- map["resultCode"]
        resultDesc          <- map["resultDesc"]
        exception           <- map["exception"]
        data                <- map["data"]
    }
    
    
    // MARK: Transforms
    let transform = TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
        
        if value == "true" {
            return true
        }
        
        return false
        
    }, toJSON: { (value: Bool?) -> String? in
        
        if let value = value {
            
            if value == true {
                return "true"
            }
            
            return "false"
        }
        
        return "false"
    })
    
}
