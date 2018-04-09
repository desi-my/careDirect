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
    
    
} //************ End Class


