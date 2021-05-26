//
//  RegisterViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/24/21.
//

import Foundation
import Parse
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userLabel: UITextField!
    @IBOutlet weak var pwdLabel: UITextField!
    @IBOutlet weak var validatePwd: UITextField!
    @IBOutlet weak var errMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.delegate = self
        pwdLabel.delegate = self
        validatePwd.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//to hide keyboard
        userLabel.resignFirstResponder()
        pwdLabel.resignFirstResponder()
        validatePwd.resignFirstResponder()
        return true
    }
    @IBAction func register(_ sender: Any) {//when register button is pressed
       
        if pwdLabel.text == validatePwd.text{//check if password and re-type are same
        let user = PFUser()//register username and password to db by taking value of textfields
                user.username = self.userLabel.text
                user.password = self.pwdLabel.text
                
                
                user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
                    
                    if let error = error {//pop an alert if theres error from db side
                        let alert = UIAlertController(title: "Credential Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    } else {//pop an alert if register success then go back using navigation controller
                        let alert = UIAlertController(title: "Register success", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                            _ = self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                    }
                }
        
        }else{//if passwords not same ask user to retype
            let alert = UIAlertController(title: "Credential Error", message: "passwords does not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
            self.present(alert, animated: true)
            validatePwd.text = ""
            pwdLabel.text = ""
        }
        
    }
}
