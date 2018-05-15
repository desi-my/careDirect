//
//  QuestionModel.swift
//  careDirect
//
//  Created by Desislava Yovcheva on 5/4/18.
//  Copyright © 2018 Daisy Yovcheva. All rights reserved.
//

import UIKit
import Firebase


class QuestionModel {
    
    var title: String?
    var step: String?
    var question: String?

    init(Title: String?, Step: String?, Question: String?) {
        self.title = Title;
        self.step = Step;
        self.question = Question;

    }
    
}
