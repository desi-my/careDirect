//
//  MapVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/25/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit


class MapVC: UIViewController {
    
    // @IBOutlet weak var mapKit: MKMapView!
    
   // let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     /*   locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() */
    }

    
   
  /*  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = locations[0]
        
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapKit.setRegion(region, animated: true)
        mapKit.showsUserLocation = true
    }
    
*/


}
