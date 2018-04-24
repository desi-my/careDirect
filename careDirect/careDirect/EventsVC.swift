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
    
    @IBOutlet weak var pinView: PinView!
    
    
    var refEvents: DatabaseReference!
    var eventsList = [EventModel]()
    
    var selectedEvent: EventModel?
    
    var pins =  [PinModel]()
    
    
    func setupMapView() {
        
        //1.  Setting the Initial location
        let initialLocation = CLLocation(latitude: 47.608013, longitude: -122.335167)
        zomMapOn(location: initialLocation)
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.delegate = self
    }
    
    // 1 Check Location Service
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServiceAuthenticationStatus()
    }
    
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
    

    // Custom Pin Icons
    /* func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  
        
     if !(annotation is MKPointAnnotation) {
           return nil
        }
     
        let annotationIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            
            annotationView?.rightCalloutAccessoryView = btn
            btn.tintColor = UIColor.blue
        }else {
            annotationView!.annotation = annotation
        }
        
       let orgButton = UIButton(type: UIButtonType.custom) as UIButton
        orgButton.frame.size.width = 44
        orgButton.frame.size.height = 44
        orgButton.backgroundColor = UIColor.blue
        orgButton.setImage(UIImage(named: "Org"), for: .normal)
        
        annotationView?.leftCalloutAccessoryView = orgButton
        
        let pinImage = UIImage(named: "pin")
        annotationView!.image = pinImage
        return annotationView
   }  */
    
    //
    
    

/* func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
    //    mapView.deselectAnnotation(annotation, animated: false)
    //    Show an alert containing the annotation's details
    
let ac = UIAlertController(title: "placeName", message: "This is exapme", preferredStyle: .alert)
   ac.addAction(UIAlertAction(title: "OK", style: .default))
   present(ac, animated: true)
    }  */
    
    
func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        print("Pin clicked");
        
        print (pinView.lblTitle.text!)
      //  self.pinView.lblDate.text = eventDate as? String
      //  self.pinView.lblOrganization.text = eventOrganization as? String
        
        let pinModel = view.annotation as? PinModel
        if (pinModel != nil) {
            self.pinView.lblTitle.text = pinModel?.titlePin;
            self.pinView.lblDate.text = pinModel?.datePin;
            self.pinView.lblOrganization.text = pinModel?.organizationPin;
        }
        self.pinView.isHidden = false;
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut, animations: {
            let _:CGRect = self.pinView.frame
            let newFrame:CGRect = CGRect(x: 0, y:390, width: self.pinView.frame.size.width, height: self.pinView.frame.size.height)
            self.pinView.frame = newFrame
              self.pinView.alpha = 1
            
        }, completion: { finished in
            // animation completed - do sometthing
            self.pinView.isHidden = false
        })

    }
    
    
    
 /*   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let capital = view.annotation as! EventModel
        let placeName = capital.title
        let placeInfo = capital.date
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } */
    
    
   // custom image annotation - Ok

 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    if annotation is MKUserLocation {
        //return nil so map view draws "blue dot" for standard user location
        return nil
    }
    
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage(named: "pin")
        
        return annotationView
    }


    
 /*   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? MKPointAnnotation {
            self.mapView.removeAnnotation(annotation)
        }
    }   */
    

    //how many sections are in your table
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
    
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
        print("row: \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetails") {
            let nextScene = segue.destination as! EventViewController
            let indexPath = tableEventsContainer.indexPathForSelectedRow!
            selectedEvent  = eventsList[indexPath.row]
            nextScene.detailsModel = selectedEvent
        }
    }

    
   //***************** Reference to Firabse Database ********************//
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.updatesVisibleSegment()
        self.setupMapView()
       mapView.delegate = self
        
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
                            
                            
                      
                        let customAnnotation = PinModel(titleP: (eventTitle as? String)!, locationP: eventLocation as! String, dateP: eventDate as! String,  organizationP: eventOrganization as! String, coordinate: coordinates)
                        self.mapView.addAnnotation(customAnnotation)
                         //self.mapView.showAnnotations([customAnnotation], animated: true)
                            
                       
                            //self.mapView.addAnnotation(pointAnnotation)
                            
                      //     self.mapView.addAnnotation(pointAnnotation)
                        //    self.mapView.centerCoordinate = coordinates
                        //   self.mapView.selectAnnotation(pointAnnotation, animated: true)
                            

                            
                    //         func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                         //    print("annotation pressed")
                      //          if let annotation = view.annotation as? MKPointAnnotation {
                       //             self.mapView.removeAnnotation(annotation)
                          //      }
                       //      } // end remove
                            
                        }
                        
                        
                    })   // End map
            
                    
                  

                    let event = EventModel(Title: eventTitle as! String?, Location: eventLocation as! String?, Date: eventDate as! String?, Organization: eventOrganization as! String?, Description: eventDescription as! String?, URL: eventUrl as! String? )
                   self.eventsList.append(event)
                    
                }
                self.tableEventsContainer.reloadData()
            }
        })
        
    }    //end viewDidLoad
    

    
    
/*    func mapView(_ mapView: MKMapView, annotationCanShowCallout annotation: MKAnnotation) -> Bool {
        return false
    }
    
    func mapView(_ mapView: MKMapView, leftCalloutAccessoryViewFor annotation: MKAnnotation) -> UIView? {
        if (annotation.title! == "Kinkaku-ji") {
            // Callout height is fixed; width expands to fit its content.
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            label.textAlignment = .right
            label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
            label.text = "金閣寺"
            
            return label
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rightCalloutAccessoryViewFor annotation: MKAnnotation) -> UIView? {
        return UIButton(type: .detailDisclosure)
    }
    
    func mapView(_ mapView: MKMapView, annotation: MKAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        //     mapView.deselectAnnotation(annotation, animated: false)
        
        // Show an alert containing the annotation's details
        let alert = UIAlertController(title: annotation.title!!, message: "A lovely (if touristy) place.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }  */
    
    
    
    //******** Segmented Control ***********************************//
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        self.updatesVisibleSegment()
    }
    
    func updatesVisibleSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.mapView.isHidden = true
            self.tableEventsContainer.isHidden = false
            self.addEventButton.isHidden = false
              self.pinView.isHidden = true;
        } else {
            self.mapView.isHidden = false
            self.tableEventsContainer.isHidden = true
            self.addEventButton.isHidden = true
            self.pinView.isHidden = false;
            checkLocationServiceAuthenticationStatus()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    }
    
//*************** End Class






