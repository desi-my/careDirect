//
//  ListVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/25/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase


class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var refEvents: DatabaseReference!
    
    @IBOutlet weak var tableEvents: UITableView!
    
    var eventsList = [EventModel]()
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let event: EventModel
        event = eventsList[indexPath.row]
        cell.lblTitle.text = event.title
        cell.lblLocation.text = event.location
        cell.lblDate.text = event.date
   
         return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
                    
                    let eventOrganization = eventObject?["Organization"]
                      let evenDescription = eventObject?["Description"]
                    
                    let event = EventModel(Title: eventTitle as! String?, Location: eventLocation as! String?, Date: eventDate as! String?, Organization: eventOrganization as! String?, Description: evenDescription as! String?, URL: eventUrl as! String?)
                    self.eventsList.append(event)
                }
                self.tableEvents.reloadData()
            }
        })
    }





}
