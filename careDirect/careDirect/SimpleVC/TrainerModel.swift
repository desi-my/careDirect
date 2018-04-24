//
//  TrainerModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/23/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

//
//  ResorcesModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/21/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import MapKit

class TrainerModel {
    
    var name: String?
    var organization: String?
    var location: String?
    var phone: String?
    var email: String?
     var url: String?
    
    init(Name: String?, Organization: String?, Email: String?, Phone: String?, Location: String?, URL: String?) {
        
        //  init(Title: String?, Location: String?, Date: String?, URL: String?) {
        
        self.name = Name;
        self.organization = Organization;
        self.location = Email;
        self.phone = Phone;
         self.email = Email;
         self.url = URL;
        
    }
    
}

