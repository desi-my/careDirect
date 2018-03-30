//
//  ListTableViewCell.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 3/2/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

@IBOutlet weak var lblTitle: UILabel!
@IBOutlet weak var lblLocation: UILabel!
@IBOutlet weak var lblDate: UILabel!
@IBOutlet weak var lblImage: UIImageView!

override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
}

func customInit(evTitlle: String, evLocation: String, evDate: String, evImage: UIImage){
    self.lblTitle.text = evTitlle
    self.lblLocation.text = evLocation
    self.lblDate.text = evDate
    self.lblImage.image = evImage
}
}
