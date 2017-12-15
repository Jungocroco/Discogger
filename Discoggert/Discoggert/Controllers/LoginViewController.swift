//
//  ViewController.swift
//  Discoggert
//
//  Created by Timo den Hartog on 04-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //////////////////////////////////////////////////
    
    
    
    let loginToList = "LoginToList"
    
    // Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    // Actions
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        Auth.auth().signIn(withEmail: textFieldLoginEmail.text!,
                              password: textFieldLoginPassword.text!)
        performSegue(withIdentifier: loginToList, sender: nil)
    }
    
    // registering users and integrating Firebase
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
            // 1
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            print(emailField.text!)
            print(passwordField.text!)
            // 2
            Auth.auth().createUser(withEmail: emailField.text!,
                                        password: passwordField.text!) { (user, error) in
                if error == nil {
                    // 3
                    Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                        password: self.textFieldLoginPassword.text!)
                                        }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}




