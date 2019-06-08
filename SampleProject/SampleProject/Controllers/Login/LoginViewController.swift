//
//  ViewController.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit
import SwiftValidator


class LoginViewController: BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var userNameTextFieldView: MATextFieldView!
    @IBOutlet weak var passwordTextFieldView: MATextFieldView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - Variables
    let validator = Validator()
    
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViewUI()
    }
    
    
    //MARK: - Setup Methods
    fileprivate func setupLoginViewUI() {
        loginButton.shadow(color: .lightGray)
        setTextField()
    }
    
    fileprivate func setTextField() {
        
        validator.registerField(userNameTextFieldView.textField, errorLabel: userNameTextFieldView.errorLabel, rules: [RequiredRule()])
        
        validator.registerField(passwordTextFieldView.textField, errorLabel: passwordTextFieldView.errorLabel, rules: [RequiredRule(), MinLengthRule(length: 6)])
    }
    
    
    //MARK: - IBAction
    @IBAction func loginButtonAction(_ sender: UIButton) {
        validator.validate(self)
    }

}


//MARK: - API Methods
extension LoginViewController {
    
    fileprivate func LoginAPI() {
        startLoading()
        RegistrationAPIs.loginUser(userName: userNameTextFieldView.textField.text ?? "", password: passwordTextFieldView.textField.text ?? "") { (message, isSucess) in
            
            self.stopLoading()
            if isSucess {
                Utility.showSucessWith(message: message ?? "")
            } else {
                Utility.showErrorWith(message: message ?? "")
            }
        }
    }
}


//MARK: - ValidationDelegate Methods
extension LoginViewController: ValidationDelegate {
    
    func validationSuccessful() {
        LoginAPI()
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
        for (field, error) in errors {
            if field is UITextField {
            }
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
}
