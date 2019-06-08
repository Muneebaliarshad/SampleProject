//
//  UIColor.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

extension UIColor {
    
    final class func CustomColorFromHexaWithAlpha (_ hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in:(CharacterSet.whitespacesAndNewlines as CharacterSet) as CharacterSet).uppercased()
        
        if cString.hasPrefix("#") {
            cString = String(cString[cString.startIndex...])
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class func randomColour() -> UIColor {
        return UIColor( red: .random(), green: .random(), blue:  .random(), alpha: 1.0)
    }
    
    final class func ThemeColor(_ alpha: CGFloat) -> UIColor {
        let hex = "F79E1B"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: alpha)
    }
    
    final class func ErrorColor(_ alpha: CGFloat) -> UIColor {
        let hex = "FF0000"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: alpha)
    }
    
    final class func SucessColor(_ alpha: CGFloat) -> UIColor {
        let hex = "008000"
        return UIColor.CustomColorFromHexaWithAlpha(hex, alpha: alpha)
    }
    
}
