//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email  = emailTextfield.text, let pwd = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: pwd){ authResult, error in
                if(error == nil){
                    self.performSegue(withIdentifier: Constants.loginToChat, sender: self)
                }else{
                    print("error ==> ", error?.localizedDescription ?? "")
                }
                
            }
        }
        
       
    }
    
}
