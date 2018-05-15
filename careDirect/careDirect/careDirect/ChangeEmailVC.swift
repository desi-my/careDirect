//
//  ChangeEmailVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/29/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
class ChangeEmailVC: UIViewController {
    
    @IBOutlet weak var updateEmailTextField: UITextField!
    
    @IBAction func closeModal(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func updateEmailTapped(_ sender: UIButton) {
        
        
        Auth.auth().currentUser?.updateEmail(to: updateEmailTextField.text!, completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                
                self.displayMySuccessMessage(successMessage: "Email Updated!");
                
                
            }
        })
        
  /*      let userRef = Database.database().reference().child("users")
    
        
        if updateEmailTextField.text == "" {
            updateEmailTextField.text = "email Missing"
        } else {
            if let user = Auth.auth().currentUser {
                user.updateEmail(to: updateEmailTextField.text!, completion: { (error) in
                    
                    if let error = error{
                        print(error.localizedDescription)
                    } else {
                        
                        self.displayMySuccessMessage(successMessage: "Email Updated!");

                   
                    }
                })
            //    self.e_mail = self.updateEmailTextField.text
             //   print(self.e_mail)
            }
        }  */
        
    //    let updatenote = UserDetails(username: user_name!, firstname: first_name!, lastname: last_name!, email: e_mail!, phno: ph_no!)
        
      //  print(updatenote)
        
    //    let key = user!.ref!.key
    //    print(key)
        
     //   let updateRef = rootRef.child("/users/\(key)")
        
      //  updateRef.updateChildValues(updatenote.toAnyObject())
     //   navigationController?.popViewController(animated: true)
    
        

    }



//Display Success Message with confirmation

func displayMySuccessMessage(successMessage:String){
    let myAlert = UIAlertController(title:"Congradulations!", message: successMessage, preferredStyle: UIAlertControllerStyle.alert);
    
    let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default){
        action in self.dismiss(animated: true, completion:nil);
    }
    
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
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
