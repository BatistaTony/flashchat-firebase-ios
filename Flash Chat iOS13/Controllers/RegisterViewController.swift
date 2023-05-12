//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let pwd = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
                if(error == nil){
                    self.performSegue(withIdentifier: Constants.registerToChat, sender: self)
                }else{
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        
    }
    
}
