//
//  DataModel.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 12/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation

struct DataModel {
    static var gameDescription = ""
    static var gameDescriptionTwo = ""
    static var totalQuestions = 0
    static var perQuestionDuration : Double = 0
    static var questionData : [Question] = []
    static var isGameWon = false
    static var submissionResponseFromServer = Response()
}


struct Question{
    var id:Int
    var word:String
    var options:[String] = []
    var answer:String
    var response:String = ""
    var timeTaken:Double = 5.0
    var isAttempted:Bool = false
    var isCorrect:Bool = false
    var level:Int = 2
}

struct Response {
    var score:Int = 0
    var user_highest_score : Int = 0
    var game_highest_score:Int = 0
    var correctly_attempted:Int = 0
}
