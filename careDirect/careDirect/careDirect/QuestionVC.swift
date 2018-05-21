//
//  QuestionVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/4/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import DLRadioButton
import Firebase

class QuestionVC: UIViewController {
    
    // STORYBOARD
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var radioYes: DLRadioButton!
    @IBOutlet weak var radioNo: DLRadioButton!
    @IBOutlet weak var radioNotSure: DLRadioButton!
    
    
    
    // FIREBASE
    var refQuestions: DatabaseReference!
    var refHandle: UInt!
    
    // MODEL
    var questionGroups = [QuestionGroup]()
    
    var currentQuestionGroup:QuestionGroup = QuestionGroup()
    var currentQuestion:ScreenerQuestion = ScreenerQuestion()
    var questionGroupIndex = 0
    var questionIndex = 0
    
    var attachedResourceCategories = [String]()
    
    
    
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        
        
        let selectedButton = radioYes.selected()
        let title = selectedButton?.titleLabel?.text
        //  print(title!)
        
        if (title == nil)  {
            print("alertttttttt")
            displayMyAlertMessage(userMessage: "Please Select one of the options!");
            self.view.endEditing(true)
        } else {
            
            print(title!)
            
            var selectedAnswer : Bool?
            
            
            if title == "No" {
                selectedAnswer = false
            } else if title == "Yes" {
                selectedAnswer = true
            } else {
                selectedAnswer = nil
            }
            
            
            
            
            if selectedAnswer != nil {
                
                // should we attach a resource?
                if currentQuestion.answerCorrespondingToResource == selectedAnswer {
                    
                    if (currentQuestionGroup.attachResource == false) {
                        currentQuestionGroup.attachResource = true
                        print("attaching resource to current question group!")
                        attachedResourceCategories.append(currentQuestionGroup.title)
                    }
                    
                    
                }
                
                // should we go to the next question or next question group
                if currentQuestion.alwaysGoToNextQuestion == true {
                    loadNextQuestion()
                } else {
                    if currentQuestion.answerWhichGoesToNext == selectedAnswer {
                        loadNextQuestion()
                    } else {
                        loadNextQuestionGroup()
                    }
                }
            } else {
                loadNextQuestion()
            }
        }
        
    }
    
    func setupQuestionView() {
        currentQuestionGroup = questionGroups[0]
        currentQuestion = currentQuestionGroup.questions[0]
        displayCurrentQuestion()
    }
    
    func loadQuestionsFromFB() {
        refQuestions = Database.database().reference().child("qgroup")
        refHandle = refQuestions.observe(DataEventType.value, with: {(snapshot) in
            
            let questionGroups = snapshot.value as! NSArray
            
            for qGroup in questionGroups {
                
                let qGroupDictionary = qGroup as! NSDictionary
                
                let questionsFBArray = qGroupDictionary["Questions"] as! NSArray
                
                // Create an array of questions
                var questions = [ScreenerQuestion]()
                
                // iterate over each question in the question group
                for q in questionsFBArray {
                    
                    let questionDictionary = q as! NSDictionary
                    
                    let thisQuestion = ScreenerQuestion()
                    thisQuestion.question = questionDictionary["question"] as! String
                    thisQuestion.alwaysGoToNextQuestion = questionDictionary["alwaysGoToNext"] as! Bool
                    
                    // PARSE ANSWER CORRESPONDING TO RESOURCE
                    let answerCorrespondingToResource = questionDictionary["answerCountToRes"] as! String
                    if answerCorrespondingToResource == "Yes" {
                        thisQuestion.answerCorrespondingToResource = true
                    } else if answerCorrespondingToResource == "No" {
                        thisQuestion.answerCorrespondingToResource = false
                    } else if answerCorrespondingToResource == "n/a" {
                        thisQuestion.answerCorrespondingToResource = nil
                    }
                    
                    // PARSE ANSWER WHICH GOES TO NEXT QUESTION
                    let answerWhichGoesToNext = questionDictionary["answerWhichGoesToNext"] as! String
                    if answerWhichGoesToNext == "Yes" {
                        thisQuestion.answerWhichGoesToNext = true
                    } else if answerWhichGoesToNext == "No" {
                        thisQuestion.answerWhichGoesToNext = false
                    } else if answerWhichGoesToNext == "n/a" {
                        thisQuestion.answerWhichGoesToNext = nil
                    }
                    
                    questions.append(thisQuestion)
                    
                }
                
                // Create a question group
                let thisQuestionGroup = QuestionGroup()
                thisQuestionGroup.title = qGroupDictionary["Title"] as! String
                thisQuestionGroup.questions = questions
                
                self.questionGroups.append(thisQuestionGroup)
                
            }
            self.setupQuestionView()
        })
    }
    
    // HELPER METHODS
    
    func attachToResourceBoolFromRadioTitle(title:String) -> Bool! {
        
        var returnBool : Bool!
        
        if title == "no" {
            // do nothing
        } else if title == "I'm not sure" {
            returnBool = nil
        } else if title == "Yes" {
            returnBool = true
        }
        
        print("returning")
        print(returnBool)
        
        return returnBool
        
    }
    
    func loadNextQuestionGroup() {
        
        self.radioYes.isSelected = false
        self.radioNotSure.isSelected = false
        self.radioNo.isSelected = false
        
        questionGroupIndex += 1
        questionIndex = 0
        
        if (questionGroupIndex < self.questionGroups.count) {
            currentQuestionGroup = questionGroups[questionGroupIndex]
            currentQuestion = questionGroups[questionGroupIndex].questions[questionIndex]
            displayCurrentQuestion()
        } else {
            performSegue(withIdentifier: "screenerResultsSegue", sender: self)
        }
        
    }
    
    func loadNextQuestion() {
        
        self.radioYes.isSelected = false
        self.radioNotSure.isSelected = false
        self.radioNo.isSelected = false
        
        questionIndex += 1
        
        if (questionIndex < currentQuestionGroup.questions.count) {
            
            currentQuestion = currentQuestionGroup.questions[questionIndex]
            
        } else {
            loadNextQuestionGroup()
        }
        
        displayCurrentQuestion()
        
        
    }
    
    func displayCurrentQuestion() {
        
        categoryLabel.text = currentQuestionGroup.title
        questionlabel.text = currentQuestion.question
        stepLabel.text = String(format:"Step %i of %6", questionGroupIndex + 1, questionGroups.count)
        
    }
    
    // INHERITED
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadQuestionsFromFB()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // HERE YOU PASS THE attachedResourceCategories ARRAY
        // TO THE RECEIVING VIEW CONTROLLER FOR USE IN A
        // TABLE VIEW WITH SECTIONS
        
        if segue.identifier == "screenerResultsSegue" {
            
            var resultsVC : ScreenerResultsVC
            resultsVC = segue.destination as! ScreenerResultsVC
            resultsVC.attachedResourceCategories = attachedResourceCategories
            
        }
    }
    
    //Display Alert Message if any of the fields are empty
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
}
