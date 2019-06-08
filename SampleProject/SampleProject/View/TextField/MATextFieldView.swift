//
//  MATextFieldView.swift
//  SampleProject
//
//  Created by Muneeb Ali on 09/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit

import UIKit

class MATextFieldView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var view: UIView!
    var placeHolderColorValue: UIColor? = .gray
    var datePickerView = UIDatePicker()
    let dateFormatter = DateFormatter()
    var pickerView = UIPickerView()
    var pickViewDataSource = ["Data 1", "Data 2", "Data 3", "Data 4", "Data 5"]
    
    
    
    //MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    
    func xibSetup() {
        backgroundColor = .clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        textField.delegate = self
        setFont()
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
        
    }
    
    
    //MARK: - Helper Methods
    func setFont() {
        //        titleLabel.font = UIFont.montserratRegularFontSize(fontsize: 15)
        //        textField.font = UIFont.montserratLightFontSize(fontsize: 13)
    }
    
    func resetError() {
        errorLabel.isHidden = true
    }
    
    
    func hideImageView() {
        imageViewWidth.constant = 5.0
        typeImageView.alpha = 0.0
        titleLabel.alpha = 1.0
    }
}



//MARK: - IBInspectable Methods
@IBDesignable
extension MATextFieldView {
    
    @IBInspectable var fieldIcon: UIImage?{
        
        get{
            return typeImageView.image
        }
        
        set(fieldIcon){
            if(fieldIcon != nil){
                typeImageView.image = fieldIcon
            }
        }
    }
    
    
    @IBInspectable var placeHolderString: String? {
        get{
            return textField.placeholder
        }
        set(placeHolderString){
            textField.placeholder = placeHolderString
            titleLabel.text = placeHolderString
        }
    }
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return placeHolderColorValue
        }
        set(newValue) {
            placeHolderColorValue = newValue
            textField.attributedPlaceholder = NSAttributedString(string: (textField.placeholder != nil ? textField.placeholder : textField.placeholder) ?? "" , attributes:[NSAttributedString.Key.foregroundColor: newValue!
                ])
        }
    }
    
    
    @IBInspectable var isSecure: Bool{
        get{
            return textField.isSecureTextEntry
        }
        set(isSecure){
            if(isSecure){
                textField.isEnabled = false
                textField.isSecureTextEntry = true
                textField.isEnabled = true
            }else{
                textField.isEnabled = false
                textField.isSecureTextEntry = false
                textField.isEnabled = true
            }
        }
    }
    
    
    @IBInspectable var isPickerView: Bool {
        get {
            return false
        }
        set(isPickerView) {
            textField.inputView = pickerView
            pickerView.delegate = self
        }
    }
    
    
    @IBInspectable var isDateTimePickerView: Bool {
        get {
            return false
        }
        set(isDateTimePickerView) {
            setDateTimePickerView()
        }
    }
    
}



//MARK: - UITextFieldDelegate Methods
extension MATextFieldView: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        titleLabel.alpha = 1.0
        resetError()
        if isPickerView {
            textField.text = pickViewDataSource[0]
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            titleLabel.alpha = 0.0
        }
    }
}



//MARK: - Date Time Picker
extension MATextFieldView {
    
    func setDateTimePickerView() {
        
        let todaysDate = Date()
        
        datePickerView.maximumDate = todaysDate
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        textField.text = dateFormatter.string(from: sender.date)
        
    }
}


//MARK: - UIPickerViewDataSource Methods
extension MATextFieldView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewDataSource.count
    }
    
}


//MARK: - UIPickerViewDelegate Methods
extension MATextFieldView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewDataSource[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickViewDataSource[row]
    }
}
