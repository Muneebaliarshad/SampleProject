//
//  RouteUrls.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation


//MARK: - Base URL
#if DEBUG
let kBaseURL = ""
#else
let kBaseURL =  ""
#endif


//MARK: - EndPoints
enum Route: String {
    
    //MARK: - Registration
    case Signin = "/signin"
    
    
    func url() -> String{
        return kBaseURL + self.rawValue
    }
    
}
