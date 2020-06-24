//
//  LoadingView.swift
//  BaseProject
//
//  Created by Muneeb Ali on 24/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    //MARK: - IBOutlets
    
    
    //MARK: - Variables
    var view: UIView!
    let circleLayer = CAShapeLayer()
    
    
    //MARK: - CAAnimation Variables
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    
    //MARK:- Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = view.center
        let radius = CGFloat(50) //min(bounds.width, bounds.height) / 7 - circleLayer.lineWidth / 2
        
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = startAngle + CGFloat(Double.pi * 2)
        let path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.cgPath
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLoaderView()
    }
    
    
    private func nibSetup() {
        backgroundColor = .clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        Utility.getTopViewController().view.endEditing(true)
        setupLoaderView()
        addSubview(view)
    }
    
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    
    
    
    
    //MARK: - Helper Methods
    func setupLoaderView() {
        circleLayer.lineWidth = 5
        circleLayer.fillColor = nil
        circleLayer.strokeColor = #colorLiteral(red: 0.01960784314, green: 0.2745098039, blue: 0.6078431373, alpha: 1)
        layer.addSublayer(circleLayer)
        
        circleLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        circleLayer.add(strokeStartAnimation, forKey: "strokeStart")
        circleLayer.add(rotationAnimation, forKey: "rotation")
    }
    
}

