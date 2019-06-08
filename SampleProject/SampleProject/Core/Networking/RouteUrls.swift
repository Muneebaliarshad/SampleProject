//
//  RouteUrls.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation

enum Route: String {
    
    case Login = "/login"
    
    
    func url() -> String{
        return Constants.BaseURL + self.rawValue
    }
}
