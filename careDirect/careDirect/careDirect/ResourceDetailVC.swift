//
//  ResourceDetailViewController.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/10/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class ResourceDetailVC: UIViewController {

    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var resource: ResourcesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        nameLabel.text = resource?.name
        websiteLabel.text = resource?.website
        emailLabel.text = resource?.email
        locationLabel.text = resource?.location
        phoneLabel.text = resource?.phone
    }

    
 

}
