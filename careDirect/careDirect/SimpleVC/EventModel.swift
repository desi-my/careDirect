//
//  EventModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/28/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import MapKit

class EventModel {
    
    var title: String?
    var location: String?
    var date: String?
    var url: String?
    var organization: String?
    var description: String?
    


    init(Title: String?, Location: String?, Date: String?, Organization: String?, Description: String?, URL: String?) {
    
   //  init(Title: String?, Location: String?, Date: String?, URL: String?) {
        
        self.title = Title;
        self.location = Location;
        self.date = Date;
        self.url = URL;
        
        self.organization = Organization;
        self.description = Description;
    }

}
