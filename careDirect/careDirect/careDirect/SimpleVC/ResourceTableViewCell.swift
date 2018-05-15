//
//  ResourceTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/21/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class ResourceTableViewCell: UITableViewCell {
    
    public var isExpanded: Bool = false
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
  
    
     class var expandedHeight: CGFloat { get  {return 200} }
     class var defaultHeight: CGFloat { get  {return 50} }
    
    func customInit(resName: String, resWebsite: String, resEmail: String, resPhone: String){
        self.lblName.text = resName
        self.lblWebsite.text = resWebsite
        self.lblEmail.text = resEmail
       self.lblPhone.text = resPhone
        
    }
    
   // UILabel.isEditable = false
   // UILabel.dataDetectorTypes = .link
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


