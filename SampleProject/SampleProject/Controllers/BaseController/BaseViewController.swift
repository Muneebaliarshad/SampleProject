//
//  BaseViewController.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit
import FCAlertView


class BaseViewController: UIViewController {
    
    //MARK: - Variables
    var leftSearchBarButtonItem : UIBarButtonItem?
    var rightSearchBarButtonItem : UIBarButtonItem?
    
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
//----------------------------------------------------------------------------------------------------
    //MARK: - Navigation Methods
    func setupColorNavigationBar() {
        if let font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(getFontSize())){
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.barStyle = .default
        }
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.ThemeColor(1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    func setupTransparentNavBar() {
        if let font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(getFontSize())){
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                                                            NSAttributedString.Key.foregroundColor: UIColor.ThemeColor(1.0)]
            self.navigationController?.navigationBar.barStyle = .default
        }
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    
//----------------------------------------------------------------------------------------------------
    //MARK: - App Theme Methods
    func getLabelsInView(view: UIView) -> [UILabel] {
        var results = [UILabel]()
        for subview in view.subviews {
            if subview is UILabel {
                
                results += [subview as! UILabel]
            } else {
                results += getLabelsInView(view: subview)
            }
        }
        return results
    }
    
    func applyThemeColors(){
        let allLabels = self.getLabelsInView(view: self.view)
        
        _ = allLabels.filter({$0.textColor == UIColor.black || $0.textColor == UIColor.white})
        
        let currentTheme = ThemeManager.currentTheme()
        if(currentTheme == .Default){
            for lbl in allLabels{
                lbl.textColor = .black
            }
            self.view.backgroundColor = .white
        }else{
            for lbl in allLabels{
                lbl.textColor = .white
            }
            self.view.backgroundColor = .black
        }
    }
    
    
    
//----------------------------------------------------------------------------------------------------
    //MARK: - Helper Methods
    func getFontSize() -> Int{
        if DeviceType.IS_IPHONE_4_OR_LESS {
            return 16
        }
        return 20
    }

    
    
//----------------------------------------------------------------------------------------------------
    //MARK:- Loader Methods
    func startLoading(){
        self.view.isUserInteractionEnabled = false
        self.view.showLoader()
    }
    
    func stopLoading(){
        self.view.isUserInteractionEnabled = true
        self.view.removeLoader()
    }

    
    
//----------------------------------------------------------------------------------------------------
    //MARK:- Custom Alert
    fileprivate func setAlertView() -> FCAlertView {
        let alertView = FCAlertView()
        alertView.titleColor = UIColor.black
        alertView.subTitleColor = UIColor.gray
        alertView.colorScheme = UIColor.ThemeColor(1.0)
        alertView.dismissOnOutsideTouch = true
        alertView.hideDoneButton = true
        alertView.animateAlertInFromTop = true
        alertView.animateAlertOutToBottom = true
        alertView.firstButtonTitleColor = UIColor.white
        alertView.firstButtonBackgroundColor = UIColor.ThemeColor(1.0)
        alertView.secondButtonTitleColor = UIColor.white
        alertView.secondButtonBackgroundColor = UIColor.ThemeColor(1.0)
        alertView.hideSeparatorLineView = true
        alertView.delegate = self
        alertView.avoidCustomImageTint = true
        alertView.darkTheme = false
        alertView.subtitleFont = UIFont.HelveticaNeueMedium(ofSize: 16.0)
        alertView.titleFont = UIFont.HelveticaNeueBold(ofSize: 18.0)
        alertView.firstButtonCustomFont = UIFont.HelveticaNeueMedium(ofSize: 16.0)
        alertView.secondButtonCustomFont = UIFont.HelveticaNeueMedium(ofSize: 16.0)
        
        return alertView
    }
    
    
    func showAlertWithTwoBtns(positiveBtn:String,negativeBtn:String,title:String,message:String){
        let alertView = setAlertView()
        alertView.showAlert(inView:self, withTitle: Constants.AppName, withSubtitle: message, withCustomImage:#imageLiteral(resourceName: "Logo"), withDoneButtonTitle: nil, andButtons: [negativeBtn,positiveBtn])
        
    }
    
    func showAlertWith(message:String) {
        
        let alertView = setAlertView()
        alertView.hideDoneButton = false
        
        alertView.showAlert(inView:self, withTitle: Constants.AppName, withSubtitle: message, withCustomImage: #imageLiteral(resourceName: "Logo"), withDoneButtonTitle: "Done", andButtons: nil)
        
    }

    
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //MARK: - DragableView
    func slideViewVerticallyTo(_ y: CGFloat) {
        self.view.frame.origin = CGPoint(x: 0, y: y)
    }
    
    
    func makeViewControllerDragable(sender: UIPanGestureRecognizer, view: UIView, isVideo: Bool) {
        let minimumVelocityToHide = 1500 as CGFloat
        let minimumScreenRatioToHide = 0.5 as CGFloat
        let animationDuration = 0.2 as TimeInterval
        
        switch sender.state {
        case .began, .changed:
            let translation = sender.translation(in: view)
            let y = max(0, translation.y)
            self.slideViewVerticallyTo(y)
            break
            
        case .ended:
            let translation = sender.translation(in: view)
            let velocity = sender.velocity(in: view)
            let closing = (translation.y > self.view.frame.size.height * minimumScreenRatioToHide) ||
                (velocity.y > minimumVelocityToHide)
            
            if closing {
                UIView.animate(withDuration: animationDuration, animations: {
                    self.slideViewVerticallyTo(self.view.frame.size.height)
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: animationDuration, animations: {
                    self.slideViewVerticallyTo(0)
                })
            }
            break
        default:
            UIView.animate(withDuration: animationDuration, animations: {
                self.slideViewVerticallyTo(0)
            })
            break
        }
    }
}


//MARK: - FCAlertViewDelegate Methods
extension BaseViewController : FCAlertViewDelegate{
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        if index == 1 {
        }
    }
    
    private func FCAlertViewDismissed(alertView: FCAlertView) {
        print("Delegate handling dismiss")
    }
    
    private func FCAlertViewWillAppear(alertView: FCAlertView) {
        print("Delegate handling appearance")
    }
}
