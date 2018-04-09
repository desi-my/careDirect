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
    
    var selectedEvent: EventModel?
    var tableCount = 0
    
    func setupMapView() {
        
       //1.  Setting the Initial location
       let initialLocation = CLLocation(latitude: 47.608013, longitude: -122.335167)
        zomMapOn(location: initialLocation)
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        mapView.delegate = self
       
        
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServiceAuthenticationStatus()
    } */
    
    // 2 -- Initial Location
   private let regionRadius: CLLocationDistance = 1000
    func zomMapOn(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 40.0, regionRadius * 40.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
    }
    
     // 3 -- Current Location
    
    var locationManager = CLLocationManager()
    
    func checkLocationServiceAuthenticationStatus(){
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
   /* extension EventsVC : CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            let location = locations.last!
            self.mapView.showsUserLocation = true
        }
    }  */
    
    
    //how many sections are in your table
   // func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      //  return 1
   // }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  tableCount = eventsList.count
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableEventsContainer.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
        let event: EventModel
        event = eventsList[indexPath.row]
        cell.lblTitle.text = event.title
        cell.lblLocation.text = event.location
        cell.lblDate.text = event.date
        
      //  print(event.title)
        
        
        
//**** Reatrevie Image from Storage and displat it in the UI
        
        // cell.imageView?.image = UIImage(named: "Pass")
        
       if let url = event.url {
            
            let imageStorageRef = Storage.storage().reference(forURL: url)
            
            imageStorageRef.getData(maxSize: 25 * 1024 * 1024, completion: { (data, error) in
                if let error = error {
                    print ("******* Eror Downloading Image: \(error)")
                }else {
                    //success
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
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedEvent  = eventsList[indexPath.row]
        // performSegue(withIdentifier: "showDetails", sender: self)
        /*    if ( tableCount == eventsList.count){
            selectedEvent  = eventsList[indexPath.row]
        } */
    
        print ("something silly")
        print("row: \(indexPath.row)")
        print("section: \(indexPath.section)")
        print("You selected: \(eventsList[indexPath.row])")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetails") {
            let nextScene = segue.destination as! EventViewController
            nextScene.detailsModel = selectedEvent
        }
    }

    
   //***************** Reference to Firabse Database ********************//
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.updatesVisibleSegment()
        self.setupMapView()
        
        //   print(EventsVC.description)
        //  print(EventsVC.debugDescription)
        
     //   let nib = UINib (nibName: "ListTableViewCell", bundle: nil)
     //   tableEventsContainer.register(nib, forCellReuseIdentifier: "cell")
    //Moree-- tableEventsContainer!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        refEvents = Database.database().reference().child("events");
        refEvents.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
              //  self.eventsList.removeAll()
                
                for events in snapshot.children.allObjects as![DataSnapshot] {
                    let eventObject = events.value as? [String: AnyObject]
                    let eventTitle = eventObject?["Title"]
                    let eventLocation = eventObject?["Location"]
                    let eventDate = eventObject?["Date"]
                    let eventUrl = eventObject?["URL"]
                    
                    let eventOrganization = eventObject?["Organization"]
                    let eventDescription = eventObject?["Description"]
                    
                    //Map
                    
                    let address = eventLocation as! String
                    
                    let geocoder:CLGeocoder = CLGeocoder()
                    
                    geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                        if((error) != nil){
                            print("Error", error ?? "")
                        }
                        else if (placemarks?[0]) != nil
                        {
                            let placemark:CLPlacemark = placemarks![0] as CLPlacemark
                            let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                            
                            let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                            pointAnnotation.coordinate = coordinates
                            pointAnnotation.title = eventTitle as? String
                            
                            self.mapView.addAnnotation(pointAnnotation)
                            self.mapView.centerCoordinate = coordinates
                            self.mapView.selectAnnotation(pointAnnotation, animated: true)
                        }
                        
                    })   // End map
                    
                  

                    let event = EventModel(Title: eventTitle as! String?, Location: eventLocation as! String?, Date: eventDate as! String?, Organization: eventOrganization as! String?, Description: eventDescription as! String?, URL: eventUrl as! String? )
                   self.eventsList.append(event)
                    
                }
                self.tableEventsContainer.reloadData()
            }
        })
        
        //    for (EventModel event in self.eventsList) {
        //         event.printDescription
        //    }
        
    }    //end viewDidLoad
    
    
    //******** Segmented Control ***********************************//
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        self.updatesVisibleSegment()
    }
    
    func updatesVisibleSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.mapView.isHidden = true
            self.tableEventsContainer.isHidden = false
            self.addEventButton.isHidden = false
        } else {
            self.mapView.isHidden = false
            self.tableEventsContainer.isHidden = true
            self.addEventButton.isHidden = true
            
            checkLocationServiceAuthenticationStatus()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    
}  //*************** End Class
