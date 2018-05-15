//
//  TrainerTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/23/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class TrainerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    func customInit(trainName: String, trainOrganization: String, trainLocation: String, trainImage: UIImage, trainPhone: String, trainEmail: String){
        self.lblName.text = trainName
        self.lblOrganization.text = trainOrganization
        self.lblLocation.text = trainLocation
        self.lblImage.image = trainImage
        self.lblPhone.text = trainPhone
          self.lblEmail.text = trainEmail
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
