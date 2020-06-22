//
//  UIView.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


extension UIView {

    //MARK: - IBInspectable
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            self.clipsToBounds = true
        }
    }

    
    @IBInspectable var isRoundView: Bool {
        get {
            return self.isRoundView
        }
        set(isRoundView){
            if(isRoundView){
                self.layer.cornerRadius = self.frame.size.height / 2
                self.clipsToBounds = true
            }
        }
    }

    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }


    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }


//------------------------------------------------------------------------------------
    //MARK: - Animation
    func shadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
    
    func addShadow(){
        let shadowSize = 3.0
        let shadowPath = UIBezierPath.init(rect: CGRect(x: self.frame.origin.x - CGFloat(shadowSize / 2), y: self.frame.origin.y - CGFloat(shadowSize / 2), width: self.frame.size.width + CGFloat(shadowSize), height: self.frame.size.height + CGFloat(shadowSize)))
            
      
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)//CGSizeMake(0.0, 0.0);
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath.cgPath
    }


    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }


    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }


    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }



//------------------------------------------------------------------------------------
    //MARK: - Loader Methods
    func showLoader(loaderWidth: Int = 60, loaderHeight: Int = 60) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingView.tag = 112233
        
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: loaderWidth, height: loaderHeight), type:  NVActivityIndicatorType.circleStrokeSpin, color: .gray, padding: 0.0)
        activityIndicator.center = self.center

        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        self.addSubview(loadingView)
    }

    func removeLoader() {
        DispatchQueue.main.async {
            self.subviews.forEach { (view) in
                if view.tag == 112233 {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
}
