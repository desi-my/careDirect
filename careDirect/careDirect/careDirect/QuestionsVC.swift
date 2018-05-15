//
//  QuestionsVC.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/2/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import DLRadioButton

class QuestionsVC: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var radioButton: DLRadioButton!
    
    @IBOutlet weak var radioYes: DLRadioButton!
    @IBOutlet weak var radioNo: DLRadioButton!
    @IBOutlet weak var radioNotSure: DLRadioButton!
    
    var questionGroups = [QuestionGroup()]
    
    var currentQuestionGroup:QuestionGroup = QuestionGroup()
    var currentQuestion:ScreenerQuestion = ScreenerQuestion()
    var questionGroupIndex = 0
    var questionIndex = 0
    
    
    var questions: [String: String] =  ["Q1": "Are you currently in school or a GED program?", "Q2": "If so, have you skipped or missed more than 1 class a week?", "Q3": "Are you a U.S. citizen or lawful permanent resident (with a green card)?", "Q4": "Has anyone ever forced or tricked you into coming to the United States?", "Q5": "Did this person ever extort money from you (force you to repay them)?", "Q6": "Did this person ever hold your social security, passport or driver's license ID without your permission?", "Q7": "Do you have a reliable place to live?, Have you ever ran away or been kicked out from your parent or guardian's home?", "Q8": "Do you feel safe where you sleep/stay during nights?", "Q9": "Did someone you work for physically force you to do something you didn’t feel comfortable doing?", "Q10": "Did someone you work for physically harm you in any way (beat, slap, hit, kick, punch, burn)?", "Q11": "Did someone you work for deprive you of sleep, food, water, or medical care?", "Q12": "In the past month, have you used drugs other than those prescribed by a doctor or those available “over-the-counter” (for example, marijuana, ecstasy or molly, heroin, crack, cocaine)?", "Q13" : "Did someone you work for force you to take or pay you in drugs like those described above?",  "Q14": "Did someone you work for restrict your contact family or friends, even when you weren’t working?", "Q15": "Did someone you work for trick you into doing different work than was promised?",  "Q16": "Did someone you work for force you to do something sexually that you didn’t feel comfortable doing? (Force you to trade sex for money, shelter, food or anything else?)"]
    /*
     var questions1 = ["Are you currently in school or a GED program?", "If so, have you skipped or missed more than 1 class a week?", "Are you a U.S. citizen or lawful permanent resident (with a green card)?", "Has anyone ever forced or tricked you into coming to the United States?", "Did this person ever extort money from you (force you to repay them)?", "Did this person ever hold your social security, passport or driver's license ID without your permission?", "Do you have a reliable place to live?", "Have you ever ran away or been kicked out from your parent or guardian's home?", "Do you feel safe where you sleep/stay during nights?", "Did someone you work for physically force you to do something you didn’t feel comfortable doing?", "Did someone you work for physically harm you in any way (beat, slap, hit, kick, punch, burn)?", "Did someone you work for deprive you of sleep, food, water, or medical care?", "In the past month, have you used drugs other than those prescribed by a doctor or those available “over-the-counter” (for example, marijuana, ecstasy or molly, heroin, crack, cocaine)?", "Did someone you work for force you to take or pay you in drugs like those described above?",  "Did someone you work for restrict your contact family or friends, even when you weren’t working?", "Did someone you work for trick you into doing different work than was promised?",  "Did someone you work for force you to do something sexually that you didn’t feel comfortable doing? (Force you to trade sex for money, shelter, food or anything else?)"]
     
     */
    
    
    var index = 0
    var  value = 0
    
    func setup() {
        
            currentQuestionGroup = questionGroups[0]
            currentQuestion = currentQuestionGroup.questions[0]
        
    }
    
    func setupQuestions() {
        
        // Get a snapshot of the questions node in firebase
        
        // iterate over every question group
        
            // iterate over child of questions group
        
            //
        
        let questionGroup1 = QuestionGroup()
        questionGroup1.title = "Education"
        
        let question1 = ScreenerQuestion()
        
        question1.question = "Q1 Are you currently in school or a GED program?"
        question1.answerCorrespondingToResource = false
        question1.alwaysGoToNextQuestion = false
        
        let question2 = ScreenerQuestion()
        
        question2.question = "Q2 If so, have you skipped or missed more than 1 class a week?"
        question2.answerCorrespondingToResource = true
        question2.alwaysGoToNextQuestion = false
        
        let question3 = ScreenerQuestion()
        
        question3.question = "Q2 If so, have you skipped or missed more than 1 class a week?"
        question3.answerCorrespondingToResource = true
        question3.alwaysGoToNextQuestion = false
        
        let question4 = ScreenerQuestion()
        
        question4.question = "Q2 If so, have you skipped or missed more than 1 class a week?"
        question4.answerCorrespondingToResource = true
        question4.alwaysGoToNextQuestion = false
        
        
        let questions = [question1, question2, question3, question4]
        questionGroup1.questions = questions
        questionGroups.removeAll()
        self.questionGroups.append(questionGroup1)
        
        
        //group 2
      /*  let questionGroup2 = QuestionGroup()
        questionGroup2.title = "Immigration"
        
        let question3 = ScreenerQuestion()
        
        question3.question = "Q1 Are you a U.S. citizen or lawful permanent resident (with a green card)?"
        question3.answerCorrespondingToResource = false
        question3.alwaysGoToNextQuestion = false
        
        let question4 = ScreenerQuestion()
        
        question4.question = "Q2 Has anyone ever forced or tricked you into coming to the United States?"
        question4.answerCorrespondingToResource = true
        question4.alwaysGoToNextQuestion = false
        
         let questionsGroupTwo = [question3, question4]
        questionGroup2.questions = questionsGroupTwo
        questionGroups.removeAll()
        self.questionGroups.append(questionGroup2)   */

        
    }
    
    

    
    func loadNextQuestionGroup() {
        
        questionGroupIndex += 1
        
        if (questionGroupIndex < self.questionGroups.count) {
            currentQuestionGroup = questionGroups[questionGroupIndex]
        } else {
            print("END OF QUESTION GROUPS")
            exit(EXIT_FAILURE)
        }
    }
    
    func loadNextQuestion() {
        
        questionIndex += 1
        
        if (questionIndex < currentQuestionGroup.questions.count) {
            
            currentQuestion = currentQuestionGroup.questions[questionIndex]
            
        }else {
            loadNextQuestionGroup()
        }
    }
    
    func displayCurrentQuestion() {
        
        categoryLabel.text = currentQuestionGroup.title
        questionlabel.text = currentQuestion.question
        stepLabel.text = String(format:"Step %i out of %6", questionGroupIndex + 1, questionGroups.count)
        
    }
    
    
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        
//        for (index, value) in questions.enumerated() {
//            print("Item \(index+1): \(value)")
//        }
        
        
        
        loadNextQuestion()
        displayCurrentQuestion()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupQuestions()
        setup()
        displayCurrentQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}  //**************End Class*******
