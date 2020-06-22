//
//  UIButton.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

extension UIButton {

    //MARK: - Nib Method
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Helper Methods
    func underline(str: String) {
        let underlineAttribute = [.underlineStyle: NSUnderlineStyle.single.rawValue, .font : UIFont.RobotoMedium(ofSize: 15.0),.foregroundColor : UIColor.lightGray, .underlineColor : UIColor.lightGray] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: str, attributes: underlineAttribute)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    
    func enable(){
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }
    
    func disable(){
        self.alpha = 0.4
        self.isUserInteractionEnabled = false
    }
    
}
