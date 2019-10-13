//
//  Networking.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 11/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkingProtocol {
    func requestSuccess()
    func requestFailed(with error : Error)
}

class Networking {
    
    static var delegate : NetworkingProtocol?
    
     static func generateGame() {
    AF.request("http://test.knudge.me/api/v1/games/air_balloon?user_id=23&app_version=1.0.1&platform=ios&device_id=abcd&session_token=abcd1234").responseJSON { (response) in
        switch(response.result){
        case .success(let value):
            let json = JSON(value)
            let rawDescription = json["payload"]["description"].stringValue.components(separatedBy: "<br><br>")
            DataModel.gameDescription = rawDescription.first! + rawDescription.last!
            DataModel.totalQuestions = json["payload"]["total_questions"].intValue
            DataModel.perQuestionDuration = Double(json["payload"]["per_question_duration"].intValue)
            
            let gameJSON = json["payload"]["game"].arrayValue
            for item in gameJSON{
                DataModel.questionData.append(
                    Question(id:item["id"].intValue ,word: item["word"].stringValue,
                                                    options: (item["options"].arrayObject as! [String]),
                                                    answer: item["answer"].stringValue))
            }
            break
        case .failure(let error):
            print(error)
            break
        }
        }
    }
    
    static func submitGame(){
        
        var gameDataDictArray = [[String: Any]]()
        
        for gameObject in DataModel.questionData {
            var dict = [String: Any]()
            dict["id"] = gameObject.id
            dict["response"] = gameObject.response
            dict["time_taken"] = gameObject.timeTaken
            dict["is_attempted"] = gameObject.isAttempted
            dict["is_correct"] = gameObject.isCorrect
            dict["level"] = gameObject.level
            gameDataDictArray.append(dict)
        }
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""

        let params : [String:Any] = ["user_id":23,
                                    "app_version": "1.5.1",
                                    "platform": "ios",
                                    "device_id": deviceId,
                                    "total_questions": 10,
                                    "per_question_duration": 5,
                                    "gam_data": gameDataDictArray,
                                    "game_won": DataModel.isGameWon]
        
        let jsonParameters = JSON(rawValue: params)

        
        let headers : HTTPHeaders = ["Host": "test.knudge.me",
                                    "Content-Type": "application/json",
                                    "Session-Token": "abcd1234"]
        AF.request("http://test.knudge.me/api/v1/games/air_balloon", method: .post, parameters: jsonParameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { (response) in
                switch(response.result){
                case .success(let value):
                    let json = JSON(value)
                    let item = json["payload"]
                    DataModel.submissionResponseFromServer = Response(score: item["score"].intValue,
                                                                      user_highest_score: item["user_highest_score"].intValue, game_highest_score: item["game_highest_score"].intValue, correctly_attempted: item["correctly_attempted"].intValue)
                    self.delegate?.requestSuccess()
                break
                case .failure(let error):
                    print(error)
                    self.delegate?.requestFailed(with: error)
                }
        }
    }
}
