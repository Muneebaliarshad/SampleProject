//
//  AlertView.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
    func positiveButtonAction()
    func negitiveButtonAction()
}


class AlertView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var negitivebutton: UIButton!
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var saperatorView: UIView!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var view: UIView!
    var delegate: AlertViewDelegate?
    
    
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
        Utility.getTopViewController().view.endEditing(true)
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    //MARK: - Setup Methods
    fileprivate func setAlertImage(_ isSucess: Bool) {
        if isSucess {
            typeImageView.image = #imageLiteral(resourceName: "Sucess.png")
        } else {
            typeImageView.image = #imageLiteral(resourceName: "Error")
        }
    }
    
    func setAlertWithMessage(isSucess: Bool, title: String, message: String) {
        setAlertImage(isSucess)
        titleLabel.text = title
        detailLabel.text = message
        saperatorView.isHidden = true
        buttonHeight.constant = 0
        positiveButton.isHidden = true
        negitivebutton.isHidden = true
    }
    
    func setAlertWithSingleButton(isSucess: Bool, title: String, message: String, positiveButtontitle: String) {
        setAlertImage(isSucess)
        titleLabel.text = title
        detailLabel.text = message
        positiveButton.setTitle(positiveButtontitle, for: .normal)
        negitivebutton.isHidden = true
    }
    
    func setAlert(isSucess: Bool, title: String, message: String, positiveButtontitle: String, negitiveButtontitle: String) {
        setAlertImage(isSucess)
        titleLabel.text = title
        detailLabel.text = message
        positiveButton.setTitle(positiveButtontitle, for: .normal)
        negitivebutton.setTitle(negitiveButtontitle, for: .normal)
    }
    
    
    //MARK: - IBAction
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        delegate?.negitiveButtonAction()
        removeFromSuperview()
    }
    
    @IBAction func positiveButtonAction(_ sender: UIButton) {
        delegate?.positiveButtonAction()
        removeFromSuperview()
    }
    
    @IBAction func negitiveButtonAction(_ sender: UIButton) {
        delegate?.negitiveButtonAction()
        removeFromSuperview()
    }
}
