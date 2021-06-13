//
//  Questions.swift
//  Edutainment
//
//  Created by Nathan Eastwood on 12/06/2021.
//

import Foundation

struct Questions {
    var questions = [Question]()
    
    init(timesUpTo: Int, numberOfQuestions: Int) {
        questions = generateQuestions(timesUpTo: timesUpTo, numberOfQuestions: numberOfQuestions)
    }
    
    func generateQuestions(timesUpTo: Int, numberOfQuestions: Int) -> [Question] {
        var questions = [Question]()
        
        for i in 1...timesUpTo {
            for j in 1...timesUpTo {
                questions.append(
                    Question(question: "\(i) * \(j) =", answer: String(i * j))
                )
            }
        }
        
        questions.shuffle()
        return Array(questions[0..<numberOfQuestions])
    }
}
