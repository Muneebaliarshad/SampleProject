//
//  Optional.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var onEmpty: String {
        return self ?? ""
    }
}


extension Optional where Wrapped == Int {
    var onEmpty: Int {
        return self ?? 0
    }
}
