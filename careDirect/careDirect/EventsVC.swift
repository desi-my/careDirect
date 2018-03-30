//
//  EventsVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/25/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation


class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {

@IBOutlet weak var mapView: MKMapView!
@IBOutlet weak var segmentedControl: UISegmentedControl!
@IBOutlet weak var tableEventsContainer: UITableView!
@IBOutlet weak var addEventButton: UIButton!

var refEvents: DatabaseReference!
var eventsList = [EventModel]()

let locationManager = CLLocationManager()


@IBAction func segmentChanged(_ sender: UISegmentedControl) {
    
    if sender.selectedSegmentIndex == 0 {
        self.mapView.isHidden = true
        self.tableEventsContainer.isHidden = false
        self.addEventButton.isHidden = false
    } else {
        self.mapView.isHidden = false
        self.tableEventsContainer.isHidden = true
        self.addEventButton.isHidden = true
    }
    
}




func setupMapView() {
    
    //1. TODO implement setup map view
    
    
    //2.  Setting the initial location
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
 
    //3.  Iterative over events array and pulling out location data
    
    //4.  creating place markers for each event
    
}


// 2 -- Current Location
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    let location = locations[0]
    
    let center = location.coordinate
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: center, span: span)
    
    mapView.setRegion(region, animated: true)
    mapView.showsUserLocation = true
    
}




func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventsList.count
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let cell = tableEventsContainer.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
    let event: EventModel
    event = eventsList[indexPath.row]
    cell.lblTitle.text = event.title
    cell.lblLocation.text = event.location
    cell.lblDate.text = event.date
    
    //add image
    // cell.imageView?.image = UIImage(named: "Pass")
    
    if let url = event.url {
        
        let imageStorageRef = Storage.storage().reference(forURL: url)
        
        imageStorageRef.getData(maxSize: 25 * 1024 * 1024, completion: { (data, error) in
            if let error = error {
                print ("******* Eror Downloading Image: \(error)")
            }else {
                //succeess
                if let imageData = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        cell.lblImage.image = image
                    }
                }
            }
        })
    }
    return cell
    
}



override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupMapView()
    
    let nib = UINib (nibName: "ListTableViewCell", bundle: nil)
    tableEventsContainer.register(nib, forCellReuseIdentifier: "cell")
    
    refEvents = Database.database().reference().child("events");
    refEvents.observe(DataEventType.value, with: {(snapshot) in
        if snapshot.childrenCount>0 {
            self.eventsList.removeAll()
            
            for events in snapshot.children.allObjects as![DataSnapshot] {
                let eventObject = events.value as? [String: AnyObject]
                let eventTitle = eventObject?["Title"]
                let eventLocation = eventObject?["Location"]
                let eventDate = eventObject?["Date"]
                let eventUrl = eventObject?["URL"]
                
                
                let event = EventModel(Title: eventTitle as! String?, Location: eventLocation as! String?, Date: eventDate as! String?, URL: eventUrl as! String? )
                self.eventsList.append(event)
            }
            self.tableEventsContainer.reloadData()
        }
        
    })
    
}    //end viewDidLoad


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

@IBAction func tableEventsContainer(_ sender: UISegmentedControl) {
}

}  //*************** End Class
