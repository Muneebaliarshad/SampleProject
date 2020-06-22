//
//  GenericModel.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - Model

struct APIResponseModel<T: Decodable>: Decodable {
    var isSuccess: Bool?
    var msg: String?
    var respCode: String?
    var respData: T?
}
