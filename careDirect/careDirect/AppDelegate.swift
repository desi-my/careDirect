//
//  AppDelegate.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 2/7/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?


func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Override point for customization after application launch.
    
    FirebaseApp.configure()
    
  
    return true
}



}

