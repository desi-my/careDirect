//SignUpVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/11/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpVC: UIViewController {


@IBOutlet weak var fullNameTF: UITextField!
@IBOutlet weak var organizationTF: UITextField!
@IBOutlet weak var emailTF: UITextField!
@IBOutlet weak var passwordTF: UITextField!

@IBOutlet weak var white: UIImageView!

@IBAction func onSignUpTapped(_ sender: UIButton) {
    
    let password = passwordTF.text;
    let fullName = fullNameTF.text;
    let organization = organizationTF.text;
    
  
    let email = emailTF.text!.lowercased();
     //   let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email);
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    

    
    let isValidPass = isValidPassword(password: passwordTF.text!);
    
  //  if ((password?.isEmpty)! || (fullName?.isEmpty)! || (organization?.isEmpty)!) {
    
    if ((email.isEmpty) || (password?.isEmpty)! || (fullName?.isEmpty)! || (organization?.isEmpty)!) {
        self.view.endEditing(true)
        displayMyAlertMessage(userMessage: "All fields are required");
    }else if (!isValidPass){
         displayMyAlertMessage(userMessage: "Password must contain between 6-16 characters, at least one uppercase letter, one lowercase letter and one special character");
    } else if (!isValidEmail(email: email)){
            displayMyAlertMessage(userMessage: "Email is not Valid");
    } else {
           displayMySuccessMessage(successMessage: "Registration is successful!");
            self.view.endEditing(true)
            Auth.auth().createUser(withEmail: email, password: password!, completion: { (user, error) in
            if error == nil {
                let ref = Database.database().reference().root;
                ref.child("users").child((user?.uid)!).child("Email").setValue(email)
                ref.child("users").child((user?.uid)!).child("Full Name").setValue(fullName)
                ref.child("users").child((user?.uid)!).child("Organization").setValue(organization)
            } else {
               let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }

} //end


    //Display Success Message with confirmation
    
    func displayMySuccessMessage(successMessage:String){
        let myAlert = UIAlertController(title:"Congratulation!", message: successMessage, preferredStyle: UIAlertControllerStyle.alert);
        
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



override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
}



}  // End class SignUpVC
