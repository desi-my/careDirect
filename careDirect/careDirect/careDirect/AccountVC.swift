//
//  AccountVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/5/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class AccountVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var organizationlabel: UILabel!
    
    public var loadChangePasswordVC : Bool = false
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
  //  var databaseRef : DatabaseReference! {
  //   return Database.database().reference()
   // }
    
    @IBAction func signOutTapped(_ sender: UIButton) {

        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
   
   func setupProfile(){
    
 //   Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
    
/* oki print     Database.database().reference().child("users").observe(.value, with: {(snapshot) in
        print("Users found")
        print(snapshot)    *////////
        
        
/*   let userRef = databaseRef.child("users/\(Auth.auth().currentUser!)").observe(DataEventType.value, with: {(snapshot) in
        */
    
  /*  let userRef = databaseRef.child("users/ \(Auth.auth().currentUser!)")
    userRef.observe(.value, with: {(snapshot) in
        print(snapshot)
        let user = User(snapshot: snapshot)
        
        self.emailLabel.text = user.email
        self.organizationlabel.text = user.organization
        self.nameLabel.text = user.name
   */

       /*     if let dict = snapshot.value as? [String: AnyObject]
            {
                self.nameLabel.text = dict["Full Name"] as? String
                   self.emailLabel.text = dict["Email"] as? String
                 self.organizationlabel.text = dict["Organization"] as? String
            } */
           
  
  //  })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if loadChangePasswordVC {
            performSegue(withIdentifier: "resetPasswordSegue", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        // Do any additional setup after loading the view.
       setupProfile()
    }

    override func viewWillDisappear(_ animated: Bool) {
        loadChangePasswordVC = false
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        ref = Database.database().reference()
     //   refHandle = ref.observe(.value, with: { (snapshot) in
         
       //     let dataDict = snapshot.value as! [String: AnyObject]
            
      //      print(dataDict)
    //    })
        
        if  let userID = Auth.auth().currentUser?.uid {
            ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
                var firebaseDic = snapshot.value as? [String: AnyObject]
             print(snapshot)
                
                
                let email = firebaseDic?["Email"] as!  String?
                let organization = firebaseDic?["Organization"] as!  String?
                let name = firebaseDic?["Full Name"] as!  String?
            
    /*        let email = firebaseDic?["Email"] as?  String ?? ""
            let organization = firebaseDic?["Organization"] as? String ?? ""
            let name = firebaseDic?["Full Name"] as? String ?? "" */
            
            self.emailLabel.text = email
            self.organizationlabel.text = organization
            self.nameLabel.text = name
                 })
          }   else {
                 
                self.emailLabel.text = " "
                self.organizationlabel.text = " "
                self.nameLabel.text = " "
            }
       
       
       // setupProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
