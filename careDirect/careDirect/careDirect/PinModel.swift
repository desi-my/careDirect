//
//  PinModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/18/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import MapKit

class PinModel: NSObject, MKAnnotation {
   // var coordinate: CLLocationCoordinate2D
    
    let titlePin: String?
    let locationPin: String
    let organizationPin: String
    let datePin: String
    let coordinate: CLLocationCoordinate2D
    
    var pinMode:EventModel?
    
  //   init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    init(titleP: String, locationP: String, dateP: String, organizationP: String, coordinate: CLLocationCoordinate2D) {
        self.titlePin = titleP
        self.locationPin = locationP
        self.datePin = dateP
        self.organizationPin = organizationP
        self.coordinate = coordinate
        
        super.init()
    }
     
}
