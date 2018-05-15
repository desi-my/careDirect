//
//  ResorcesModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/21/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import MapKit

class ResourcesModel {
    
    var name: String?
    var website: String?
    var email: String?
    var phone: String?
    var location: String?
    
    init(Name: String?, Website: String?, Email: String?, Phone: String?, Location: String?) {
        
        self.name = Name;
        self.website = Website;
        self.email = Email;
        self.phone = Phone;
        self.phone = Location;
        
      
    }
    
}
