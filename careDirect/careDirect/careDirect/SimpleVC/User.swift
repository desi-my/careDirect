//
//  User.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/6/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

struct User {
    
    var name: String?
    var email: String?
    var organization: String?
    var uid: String?
    var ref: DatabaseReference?
    var key: String?

    
    init (snapshot: DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
      
        email = (snapshot.value! as! NSDictionary)["Email"] as? String
        organization = (snapshot.value! as! NSDictionary)["Organization"] as? String
        uid = (snapshot.value! as! NSDictionary)["uid"] as? String
        name = (snapshot.value! as! NSDictionary)["Full Name"] as? String
    }
    

    
}
