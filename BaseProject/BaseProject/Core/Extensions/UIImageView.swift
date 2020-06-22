//
//  UIImageView.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit


extension UIImageView{
    
    //MARK: - Edit Methods
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        self.addSubview(blurEffectView)
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
        gradientLayer.colors =  [UIColor.clear.cgColor,UIColor.black.cgColor]
        //Use diffrent colors
        self.layer.addSublayer(gradientLayer)
    }
    
}
