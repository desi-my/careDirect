//
//  DetailsViewController.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 3/31/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableEventsContainer: UITableView!
    var refEvents: DatabaseReference!
    var detailsList = [DetailsModel]()
    var myIndex = 0
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // return detailsList.count
        return detailsList.count

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableEventsContainer.dequeueReusableCell(withIdentifier: "detailsCell") as! DetailsTableViewCell
        let detail: DetailsModel
        detail = detailsList[indexPath.row]
        cell.lblTitle.text = detail.title
        cell.lblLocation.text = detail.location
        cell.lblDate.text = detail.date
        cell.lblOrganization.text = detail.organization
        cell.lblDescription.text = detail.description
        
        //add image
        
        if let url = detail.url {
            
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
        
        let nib = UINib (nibName: "DetailsTableViewCell", bundle: nil)
        tableEventsContainer.register(nib, forCellReuseIdentifier: "detailsCell")
        
        refEvents = Database.database().reference().child("events");
        refEvents.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.detailsList.removeAll()
                
                for events in snapshot.children.allObjects as![DataSnapshot] {
                    let eventObject = events.value as? [String: AnyObject]
                    let eventTitle = eventObject?["Title"]
                    let eventLocation = eventObject?["Location"]
                    let eventDate = eventObject?["Date"]
                    let eventUrl = eventObject?["URL"]
                    
                    let eventOrganization = eventObject?["Organization"]
                    let eventDescription = eventObject?["Description"]
                    
                    
                    let detail = DetailsModel(Title: eventTitle as! String?, Location: eventLocation as! String?, Date: eventDate as! String?, Organization: eventOrganization as! String?, Description: eventDescription as! String?, URL: eventUrl as! String? )
                    self.detailsList.append(detail)
                }
                self.tableEventsContainer.reloadData()
            }
            
        })
        
    }    //end viewDidLoad
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    
}  //*************** End Class

    



