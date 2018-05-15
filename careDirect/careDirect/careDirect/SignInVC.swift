//  ViewController.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/7/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignInVC: UIViewController, UITextFieldDelegate {

    @IBAction func forgotPass(_ sender: Any) {
        
        
    }
    
  
     //   dismiss(animated: true, completion: nil)
      /*  if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetPassword") as? ResetPasswordVC {
            self.present(viewController, animated: false, completion: nil)
        }   */
        
    
    
    
   
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func newAccountB(_ sender: Any) {
    }

    
    @IBAction func onSignInTapped(_ sender: UIButton) {
           self.view.endEditing(true)
        
        guard emailTF.text! != "" , passwordTF.text! != "" else {return}
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            if user != nil {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessVC")
                self.present(vc, animated: true, completion: nil)
            }
        })
        
        
        
        
        
        
        
     
        
        
        
        
        
        
        
  /*      if email.isEmpty || password.isEmpty {
            
            let alertController = UIAlertController(title: "Error!", message: "Please fill in all the fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        } else {
            logIn(email: email, password: password)
        }
            
   */
            

    
        
        
        
      /*  self.view.endEditing(true)
        
        if (email.isEmpty) || (password.isEmpty)
        {
            let alert = UIAlertController(
                title: "Invalid Login",
                message: "Please fill user and password",
                preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // do something when user press OK button, like deleting text in both fields or do nothing
            }
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            return
        } else {
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print (firebaseError.localizedDescription)
                    return
                }
               // self.presentLoggedScreen()
                print("Success")
            })
        }    */
        
        
        
    /*    if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print (firebaseError.localizedDescription)
                    return
                }
               self.presentLoggedScreen()
                print("Success")
            })
        }
        
    }
    
    func presentLoggedScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "SuccessVC", bundle: nil)
        let loggedInVC:SuccessVC = storyboard.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
        self.present(loggedInVC, animated: true, completion:nil)
        
    } */
    }
    
    
    
   /* func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion:  { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName!) has logged in sucessfull")
                    
                  //  let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                //    appDel.logUser()
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
   )}  */
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forgotPasswordSegue" {
            let tabBarVC = segue.destination as! TabBarViewController
            tabBarVC.loadChangePasswordVC = true
        }
    }
    
    override func viewDidLoad() {
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            textField.placeholder = "Email"
        } else {
            textField.placeholder = "Password"
        }
    }
    
    
} // End SignInVC
