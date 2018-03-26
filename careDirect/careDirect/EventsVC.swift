//
//  EventsVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/25/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableEventsContainer: UITableView!
    
    var refEvents: DatabaseReference!
    var eventsList = [EventModel]()
    
    

    
    
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
    
  /*  if let url = event.url {
        let url = NSURL(string: url)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async() { () -> Void in
                cell.imageView?.image = UIImage(data: data!)
            }
    })
        
    }  */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        
        
      /* views = [UIView]()
        
        views.append.tableEventsContainer()
          views.append(MapVC().view)
        
        for v in views {
            tableEventsContainer.addSubview(v)
        }
        
        tableEventsContainer.bringSubview(toFront: views[0])  */
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tableEventsContainer(_ sender: UISegmentedControl) {
     //   self.tableEventsContainer.bringSubview(toFront: views[sender.selectedSegmentIndex])
       /* if sender.selectedSegmentIndex == 0 {
         //  tableEventsContainer.isHidden = false
            MapVC().view.isHidden = true
        } else {
          //  tableEventsContainer.isHidden = true
             MapVC().view.isHidden = false
            
            
        }   */
        
        
        
    }
    
}  // End Class
