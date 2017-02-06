//
//  ViewController.swift
//  AJvalidatorTextField
//
//  Created by Prabakaranm on 02/03/2017.
//  Copyright (c) 2017 Prabakaranm. All rights reserved.
//

import UIKit
import AJvalidatorTextField

class ViewController: UIViewController,ValidationDelegate,UITextFieldDelegate {

    @IBOutlet weak var UsernameErrorLabel: UILabel!
    @IBOutlet weak var username_TextField: SkyFloatingLabelTextFieldWithIcon!
    
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("Workin here")
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                
            }
            }, error:{ (validationError) -> Void in
                print("error")
                
                validationError.errorLabel?.isHidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                if let textField = validationError.field as? UITextField {
                    textField.layer.borderColor = UIColor.red.cgColor
                    textField.layer.borderWidth = 1.0
                }
        })
        self.username_TextField.becomeFirstResponder()
        
        self.applySkyscannerThemeWithIcon(textField: self.username_TextField)
        
        //Username
        self.username_TextField.iconText = "\u{f007}"
        self.username_TextField.placeholder     = "Username"
        self.username_TextField.selectedTitle   = "Enter Username"
        self.username_TextField.title           = "Username"
        self.username_TextField .delegate = self
        validator.registerField(username_TextField, errorLabel: UsernameErrorLabel , rules: [RequiredRule(), FullNameRule()])
        
        
    }
    func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField: textField)
        
        textField.iconColor = lightGreyColor
        textField.selectedIconColor = overcastBlueColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = overcastBlueColor
        
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    @IBAction func Submit_btnAction(_ sender: AnyObject) {
        
        print("Validating...")
        validator.validate(self)

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        validator.validateField(textField){ error in
        //            if error == nil {
        //                // Field validation was successful
        //            } else {
        //                // Validation error occurred
        //            }
        //        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Validation Delegate methods
    
    func validationSuccessful() {
        print("Validation Success!")
        let alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    func validationFailed(_ errors:[(Validatable, ValidationError)]) {
        print("Validation FAILED!")
    }

}

