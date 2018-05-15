//
//  DetailsModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 3/31/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

class DetailsModel {
    
    var title: String?
    var location: String?
    var date: String?
    var organization: String?
    var description: String?
    var url: String?
    
    
    init(Title: String?, Location: String?, Date: String?, Organization: String?, Description: String?, URL: String?) {
        
        self.title = Title;
        self.location = Location;
        self.date = Date;
        self.organization = Organization;
        self.description = Description;
        self.url = URL;
    }
    
}

