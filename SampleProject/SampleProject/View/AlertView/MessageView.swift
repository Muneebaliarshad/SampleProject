//
//  MessageView.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

class MessageView: UIView {

    //MARK: - IBOutlets
    @IBOutlet weak var errorLabel: UILabel!
    
    
    //MARK: - Variables
    var view: UIView!
    
    
    
    //MARK:- Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        alpha = 0
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    
    //MARK: - Setup Methods
    func setMessageView(message:String, backgroundColor:UIColor, textColor:UIColor = UIColor.white) {
        frame = CGRect(x: 0, y:  ScreenSize.SCREEN_HEIGHT - 100, width: ScreenSize.SCREEN_WIDTH - 20, height: 70)
        center = CGPoint(x: ScreenSize.SCREEN_WIDTH / 2, y: ScreenSize.SCREEN_HEIGHT - 50)
        errorLabel.text = message
        view.backgroundColor = backgroundColor
        errorLabel.textColor = textColor
        shadow(color: .gray)
        Constants.AppDelegate.window?.addSubview(self)
        fadeIn(duration: 1.0, delay: 0.0,completion: {
            (finished: Bool) -> Void in
            self.fadeOut(duration: 1.0, delay: 1.0, completion:{(finished: Bool) -> Void in
                self.removeFromSuperview()
            })
        })
    }
}
