//
//  OrganizationTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/22/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {

    public var isExpanded: Bool = false
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    class var expandedHeightOrg: CGFloat { get  {return 200} }
    class var defaultHeightOrg: CGFloat { get  {return 50} }
    
    func customInit(orgName: String, orgWebsite: String, orgEmail: String, orgPhone: String, orgLocation: String){
        self.lblName.text = orgName
        self.lblWebsite.text = orgWebsite
        self.lblEmail.text = orgEmail
        self.lblPhone.text = orgPhone
        self.lblLocation.text = orgLocation
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
