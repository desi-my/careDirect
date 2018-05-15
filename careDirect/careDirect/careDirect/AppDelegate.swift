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
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let initialViewController = sb.instantiateViewController(withIdentifier: "Onboarding")
    
    //once the user has competed the Onborading once, it will disappear
    // let userDefaults = UserDefaults.standard
    
    /*  if userDefaults.bool(forKey: "onboardingComplete"){
     initialViewController = sb.instantiateViewController(withIdentifier: "SignInVC")
     } */
    
    
    window?.rootViewController = initialViewController
    window?.makeKeyAndVisible()
    
    // Override point for customization after application launch.
    
    FirebaseApp.configure()
    
    return true
}



}

