//
//  UIFont.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

extension UIFont {
    
    final class func RobotoLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }

    final class func RobotoMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    
    final class func RobotoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
    
}
