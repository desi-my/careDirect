//
//  User.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/12/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase


class EventViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    
    
  
    
    
    
    @IBAction func backToEventsTab(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getTicketsTapped(_ sender: UIButton) {
               if let url = NSURL(string: "https://www.eventbrite.com/d/wa--seattle/trafficking/?crt=regular&sort=best"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    
    var detailsModel:EventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblDate.text = detailsModel?.date
        lblOrganization.text = detailsModel?.organization
        lblTitle.text = detailsModel?.title
        lblLocation.text = detailsModel?.location
        lblDescription.text = detailsModel?.description
      //  imageView.image = UIImage(named: "Pass" + ".png")
        

        if let url = detailsModel?.url {
            let imageStorageRef = Storage.storage().reference(forURL: url)
            
            imageStorageRef.getData(maxSize: 25 * 1024 * 1024, completion: { (data, error) in
                if let error = error {
                    print ("******* Eror Downloading Image: \(error)")
                }else {
                    //success
                    if let imageData = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            self.imageView.image = image
                        }
                    }
                }
            })
        

        }

        
    } // end didLoad
    
   
        
    
    
        
      //  let thisRes = arrayOfResourceArrays[indexPath.section][indexPath.row]
       // let siteString = thisRes.website
       // let siteURL = URL(string: siteString!)
       // UIApplication.shared.open(siteURL!)
    

    
        
       
 /*   func open() {
        let siteString =  lblLocation.text
        if let siteURL = URL(string: siteString!) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(siteURL, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(siteURL)
                print("Open \(success)")
            }
        }
    } */
    
    
    
} //************ End Class


