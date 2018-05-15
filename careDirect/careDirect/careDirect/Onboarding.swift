//
//  Onboarding.swift
//  Onboarding
//
//  Created by Becky Bach on 4/30/18.
//  Copyright © 2018 Becky Bach. All rights reserved.
//

import UIKit
import paper_onboarding

class Onboarding: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
//outlets
    
    @IBOutlet weak var onboardingObj: OnboardingViewClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingObj.dataSource = self
        onboardingObj.delegate = self
    }

    @IBOutlet weak var getStartedButton: UIButton!
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.getStartedButton.alpha == 1 {
                UIView.animate(withDuration: 0.6, animations: {self.getStartedButton.alpha = 1 })
            }
        }
    }
    
    func onboardingDidTransitionToIndex(_ index: Int){
        if index == 3 {
            UIView.animate(withDuration: 0.8, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
    
    
    
 /*   @IBAction func getStarted(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    } */
    
    
}




extension Onboarding {
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let bgOne = #colorLiteral(red: 0.2705882353, green: 0.7058823529, blue: 0.7843137255, alpha: 1)
        let bgTwo = #colorLiteral(red: 0.1921568627, green: 0.3411764706, blue: 0.4196078431, alpha: 1)
        let bgThree = #colorLiteral(red: 0.2705882353, green: 0.7058823529, blue: 0.7843137255, alpha: 1)
        let bgFour = #colorLiteral(red: 0.1921568627, green: 0.3411764706, blue: 0.4196078431, alpha: 1)
        let textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 36);
        let descFont = UIFont(name: "AvenirNext-Regular", size: 20);
        
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "CompassActive.png"),
                               title: "Find Care",
                               description: "The Care Compass uses a brief survey to recommend the most appropriate services.",
                               pageIcon: #imageLiteral(resourceName: "Active.png"),
                               color: bgOne,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont!,
                               descriptionFont: descFont!),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Events.png"),
                               title: "View Local Events",
                               description: "Explore local events related to sex trafficking awareness, including volunteering & training opportunities for classrooms and workplaces",
                               pageIcon: #imageLiteral(resourceName: "Active.png"),
                               color: bgTwo,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont!,
                               descriptionFont: descFont!),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Resources.png"),
                               title: "Check all Resources",
                               description: "Communicate with certified trainers to set up training seminars at schools or workplaces to help spread awareness for sex trafficking",
                                pageIcon: #imageLiteral(resourceName: "Active.png"),
                               color: bgThree,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont!,
                               descriptionFont: descFont!),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Training.png"),
                               title: "Get Certified Training",
                               description: "The resources tab hosts a list of all services and resources offered through careDIRECT",
                                pageIcon: #imageLiteral(resourceName: "Active.png"),
                               color: bgFour,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont!,
                               descriptionFont: descFont!),
            ][index]
    }

    }

