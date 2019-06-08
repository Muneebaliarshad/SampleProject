//
//  UIView.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit
import FCAlertView
import NVActivityIndicatorView


enum UIViewCorners: String {
    case bottomLeft
    case topLeft
    case topRight
    case bottomRight
}


extension UIView {
    
    //MARK: - IBInspectable
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
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
    

    
//----------------------------------------------------------------------------------------------------
    //MARK: - Animation
    func shadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
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
    
    func roundCorner(uiViewCorner: UIViewCorners, radius: CGFloat = 5.0) {
        switch uiViewCorner {
            
        case .topLeft:
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:[.topLeft], cornerRadii: CGSize.init(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            
        case .topRight:
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:[.topRight], cornerRadii: CGSize.init(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            
        case .bottomLeft:
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:[.bottomLeft], cornerRadii: CGSize.init(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            
        case .bottomRight:
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:[.bottomRight], cornerRadii: CGSize.init(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
    }

    
//----------------------------------------------------------------------------------------------------
    //MARK: - Loader Methods
    func showLoader(loaderWidth: Int = 50, loaderHeight: Int = 50) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingView.tag = 112233
        
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: loaderWidth, height: loaderHeight), type:  NVActivityIndicatorType.lineScalePulseOut, color: UIColor.ThemeColor(1.0), padding: 0.0)
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
