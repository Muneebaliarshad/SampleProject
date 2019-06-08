//
//  UITextField.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        updateFontForDevice()
    }
    
    func updateFontForDevice() {
        let pointSize: CGFloat?
        if DeviceType.IS_IPAD {
            pointSize = ((self.font?.pointSize)! + 5) * (UIScreen.main.bounds.width / 834)
        } else {
            pointSize = (self.font?.pointSize)! * (UIScreen.main.bounds.width / 320)
        }
        
        self.font = self.font?.withSize(pointSize ?? 00)
    }
}
