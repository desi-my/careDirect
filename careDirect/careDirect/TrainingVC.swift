//
//  TrainingVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 3/10/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class TrainingVC: UIViewController, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableContainer: UITableView!
    
    var refTrainers: DatabaseReference!
    var trainers = [TrainerModel]()
    var selectedIndexPath: TrainerModel?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainers.count
        //  return (resources.count + organizations.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainCell", for: indexPath) as! TrainerTableViewCell
        let trainer: TrainerModel
        trainer = trainers[indexPath.row]
        cell.lblName.text = trainer.name
        cell.lblOrganization.text = trainer.organization
        cell.lblLocation.text = trainer.location
        
        if let url = trainer.url {
            
            let imageStorageRef = Storage.storage().reference(forURL: url)
            
            imageStorageRef.getData(maxSize: 25 * 1024 * 1024, completion: { (data, error) in
                if let error = error {
                    print ("******* Eror Downloading Image: \(error)")
                }else {
                    //success
                    if let imageData = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            cell.lblImage.image = image
                        }
                    }
                  }
                })
        }
        
        return cell
    }
        
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let indexPath = tableContainer.indexPathForSelectedRow!
       // selectedIndexPath = trainers[indexPath.row]
    }
    
    

    
    //end test
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.updatesVisibleSegment()
        
        refTrainers = Database.database().reference().child("trainers");
        
        refTrainers.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.trainers.removeAll()
                
                for trainers in snapshot.children.allObjects as![DataSnapshot] {
                    let trainerObject = trainers.value as? [String: AnyObject]
                    let trainerName = trainerObject?["Name"]
                    let trainerOrganization = trainerObject?["Organization"]
                    let trainerLocation = trainerObject?["Location"]
                    let trainerPhone = trainerObject?["Phone"]
                    let trainerEmail = trainerObject?["Email"]
                    let trainerUrl = trainerObject?["URL"]
                    
                    let trainer = TrainerModel(Name: trainerName as! String?, Organization: trainerOrganization as! String?, Email: trainerEmail as! String?, Phone: trainerPhone as! String?, Location: trainerLocation as! String?, URL: trainerUrl as! String?)
                    self.trainers.append(trainer)
                }
                self.tableContainer.reloadData()
            }
        }) //end
        
        
    } // end override
    
}

    
    
/*@IBAction func sendEmailButton(_ sender: Any) {
    let mailCompose = MFMailComposeViewController()
    mailCompose.mailComposeDelegate = self
    mailCompose.setToRecipients(["dyovcheva@gmail.com"])
    mailCompose.setSubject("Hire Trainer")
    mailCompose.setMessageBody("Ask any questions our Certified Trainers!", isHTML: false)
    
    if MFMailComposeViewController.canSendMail() {
        self.present(mailCompose, animated: true, completion: nil)
    }else {
        print ("error!")
    }
    
}

func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
}


@IBAction func callPhoneButton(_ sender: Any) {
    let url: NSURL = URL(string: "TEL://2063832319")! as NSURL
    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
} */













