//
//  OrganizationTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/22/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    
   // class var expandedHeight: CGFloat { get  {return 200} }
 //   class var defaultHeight: CGFloat { get  {return 50} }
    
 //   func customInit(orgName: String, orgWebsite: String, orgEmail: String, orgPhone: String){
      func customInit(orgName: String){
        self.lblName.text = orgName
       // self.lblWebsite.text = resWebsite
    //    self.lblEmail.text = orgEmail
     //   self.lblPhonel.text = orgPhone
    //    self.lblAbout.text = orgPhone
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
