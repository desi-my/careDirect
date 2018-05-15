//
//  DetailsTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/1/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
   // @IBOutlet weak var lblTitle: UILabel!
  //  @IBOutlet weak var lblLocation: UILabel!
  //  @IBOutlet weak var lblDate: UILabel!
  //  @IBOutlet weak var lblImage: UIImageView!
    
    @IBOutlet weak var lblImage: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UITextView!

    @IBAction func getTickets(_ sender: UIButton) {
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func customInit(evTitlle: String, evLocation: String, evDate: String, evImage: UIImage, evOrganization: String, evDescription: String){
        self.lblTitle.text = evTitlle
        self.lblLocation.text = evLocation
        self.lblDate.text = evDate
        self.lblImage.image = evImage
        self.lblOrganization.text = evOrganization
        self.lblDescription.text = evDescription
    }
    
}
