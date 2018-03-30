//
//  TrainingVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 3/10/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import MessageUI

class TrainingVC: UIViewController, MFMailComposeViewControllerDelegate {


@IBAction func sendEmailButton(_ sender: Any) {
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
}





override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}




}
