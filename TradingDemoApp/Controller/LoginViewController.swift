//
//  LoginViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/17/21.
//

import Foundation
import UIKit
import Parse

class LoginViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var bgLabel: UILabel!
    @IBOutlet weak var uNLabel: UITextField!
    @IBOutlet weak var pwdLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if PFUser.current() != nil{//logout when a user stil logged in
            PFUser.logOut()
        }
        nameField.delegate = self
        pwdField.delegate = self
    }
    func setupView(){
        bgLabel?.layer.masksToBounds = true
        bgLabel.layer.cornerRadius = 25.0
        bgLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.maxY).isActive = true
        loginButton.layer.cornerRadius = 20.0
        loginButton.backgroundColor = UIColor.orange
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//to hide keyboard
        nameField.resignFirstResponder()
        pwdField.resignFirstResponder()
        return true
    }
    @IBAction func buttonPressed(_ sender: Any) {//change button color when clicked
        if(loginButton.backgroundColor == UIColor.orange){
            loginButton.backgroundColor = UIColor.yellow
        }else if(loginButton.backgroundColor == UIColor.yellow) {
            loginButton.backgroundColor = UIColor.orange
        }
        PFUser.logInWithUsername(inBackground: self.nameField.text!, password: self.pwdField.text!) {//check credentials in DB
                  (user: PFUser?, error: Error?) -> Void in
                  if user != nil {
                    self.performSegue(withIdentifier: "goToMain", sender: nil)//segue to mainmenu if correct
                  } else {
                    let alert = UIAlertController(title: "Credential Error", message: "Username or password is incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
                    self.present(alert, animated: true)//if not correct pop an alert
                  }
                }
    }
    
}
