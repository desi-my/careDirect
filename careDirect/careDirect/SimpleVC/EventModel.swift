//
//  EventModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/28/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

class EventModel {
    var title: String?
    var location: String?
    var date: String?
    var url: String?

   
    
    init(Title: String?, Location: String?, Date: String?, URL: String?) {
        self.title = Title;
        self.location = Location;
        self.date = Date;
        self.url = URL;
    }
}
