//
//  UITextField.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

extension UITextField {
    
    //MARK: - IBInspectable
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set(newValue) {
            attributedPlaceholder = NSAttributedString(string: (placeholder != nil ? placeholder : placeholder) ?? "" , attributes:[NSAttributedString.Key.foregroundColor: newValue!
            ])
        }
    }
    
    
    //MARK: - Nib Methods
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Padding Methds
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.rightView = paddingView
        self.leftViewMode = .always
        
    }
    
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        self.layer.masksToBounds = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.leftViewMode = .always
    }
}
