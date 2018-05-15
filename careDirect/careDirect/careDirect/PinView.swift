//
//  PinView.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/11/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PinView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    
    @IBAction func getDirections(_ sender: UIButton) {
    
    }
    


      //     let detailsModel:PinModel?
     
        
    /*      // let address = detailsModel?.locationPin

        let geocoder:CLGeocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            else if (placemarks?[0]) != nil
            {
                let placemark:CLPlacemark = placemarks![0] as CLPlacemark
                
                let mapItem = MKMapItem(placemark: placemark as! MKPlacemark)
                
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
               // pointAnnotation.title = eventTitle as? String
                
                let regionDistance :CLLocationDistance = 1000;
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
    
               // self.mapView.addAnnotation(customAnnotation)
        
        
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan:regionSpan.span)]
                
              mapItem.openInMaps(launchOptions: options)
        
    }
    
        })  */
    
    

    
    @IBAction func clodePinView(_ sender: UIButton) {
        
    
        
    //    if(contentView != nil && !contentView.isHidden)
    //    {
           // contentView.removeFromSuperview()
     //       self.contentView.isHidden = true
    //    }
        
         //  dismiss(animated: true, completion: nil)
      if sender.tag == 99 {
            print("next page")
       //     self.contentView(200)?.isHidden = true
           // self.contentView.isHidden = true
           self.contentView.alpha = 0
        } else {
            self.contentView.isHidden = false
        }  
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
