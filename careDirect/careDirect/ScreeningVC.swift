//
//  ScreeningVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 4/16/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import DLRadioButton

class ScreeningVC: UIViewController {

    @IBOutlet weak var viewHome: UIView!
    
    @IBAction func getStartedButton(_ sender: UIButton) {
        
     if sender.tag == 201 {
          print("next page")
        self.view.viewWithTag(200)?.isHidden = true
        self.view.viewWithTag(202)?.isHidden = false
       }
    }
    
    @IBOutlet weak var viewStep1a: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
