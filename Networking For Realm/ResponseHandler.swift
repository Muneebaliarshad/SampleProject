//
//  ResponseHandler.swift
//  BaseProject
//
//  Created by Muneeb Ali on 29/05/2018.
//  Copyright © 2018 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift


class ResponseHandler: Object {
    
    // MARK: - Properties
    var callStatus: Bool = false
    var resultCode: String?
    var resultDesc: String?
    var exception: String?
    var data: AnyObject? // data can be nil
    
}
