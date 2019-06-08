//
//  UIButton.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        updateFontForDevice()
    }
    
    func updateFontForDevice() {
        let pointSize: CGFloat?
        if DeviceType.IS_IPAD {
            pointSize = ((self.titleLabel?.font.pointSize)! + 5) * (ScreenSize.SCREEN_MIN_LENGTH / 834)
        } else {
            pointSize = (self.titleLabel?.font.pointSize)! * (ScreenSize.SCREEN_MIN_LENGTH  / 320)
        }
        self.titleLabel?.font = self.titleLabel?.font.withSize(pointSize ?? 0.0)
    }
}
