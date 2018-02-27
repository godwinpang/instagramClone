//
//  LoginViewController.swift
//  instagramClone
//
//  Created by Godwin Pang on 2/26/18.
//  Copyright © 2018 godwinpang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let signUpUsernameErrorAlertController = UIAlertController(title: "Username Required", message: "Please enter username", preferredStyle: .alert)
    let signUpPasswordErrorAlertController = UIAlertController(title: "Password Required", message: "Please enter password", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        //does nothing -> dismisses alert view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpUsernameErrorAlertController.addAction(OKAction)
        signUpPasswordErrorAlertController.addAction(OKAction)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        if (usernameField.text?.isEmpty)!{
            present(signUpUsernameErrorAlertController, animated: true)
        } else if (passwordField.text?.isEmpty)!{
            present(signUpPasswordErrorAlertController, animated: true)
        } else {
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let signUpErrorAlertController = UIAlertController(title: "Signup Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    signUpErrorAlertController.addAction(self.OKAction)
                    self.present(signUpErrorAlertController, animated: true)
                } else {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let loginErrorAlertController = UIAlertController(title: "Login Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                loginErrorAlertController.addAction(self.OKAction)
                self.present(loginErrorAlertController, animated: true)
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
}
