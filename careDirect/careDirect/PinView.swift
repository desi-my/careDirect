//
//  PinView.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/11/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class PinView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    
    @IBAction func getDirections(_ sender: UIButton) {
    }
    
    //for using custom view in Code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
     //for using custom view in XB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){
        
        Bundle.main.loadNibNamed("PinView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
