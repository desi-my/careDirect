//
//  TabBarViewController.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/14/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    public var loadChangePasswordVC : Bool = false
    
    func setup() {
        if loadChangePasswordVC {
            self.selectedIndex = 4
            let navigationController = self.childViewControllers[4] as! UINavigationController
            let accountVC = navigationController.topViewController as! AccountVC
            accountVC.loadChangePasswordVC = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadChangePasswordVC = false
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
