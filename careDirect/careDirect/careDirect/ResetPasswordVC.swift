//
//  ResetPasswordVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/29/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        
        let email = emailTextField.text
        
        if email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                
                if error != nil {
                    
                    // Error - Unidentified Email
                    self.displayMyAlertMessage(userMessage: "Please, re-enter the email you have registered with.");
                    
             //      showAlert(title: "Unidentified Email Address", msg: "Please, re-enter the email you have registered with.", actionButton: "OK", viewController: self)
                    
                } else {
                    
                    // Success - Sent recovery email
                    self.displayMySuccessMessage(successMessage: "An email has been sent. Please, check your email now.");
                    
                }
            })
        } else {
          displayMyAlertMessage(userMessage: "Email is required in order to reset your password. Please, enter your email!");
        }
        
    }

    
    //Display Success Message with confirmation
    
    func displayMySuccessMessage(successMessage:String){
        let myAlert = UIAlertController(title:"Email Sent!", message: successMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default){
            action in self.dismiss(animated: true, completion:nil);
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    //Display Alert Message if any of the fields are empty
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
