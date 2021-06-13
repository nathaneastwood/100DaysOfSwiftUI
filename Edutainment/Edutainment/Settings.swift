//
//  Settings.swift
//  Edutainment
//
//  Created by Nathan Eastwood on 12/06/2021.
//

import Foundation

enum NumberOfQuestions: String, CaseIterable {
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case all = "All"
}

class Settings: ObservableObject {
    @Published var timesUpTo = 1
    
    @Published var numberOfQuestionsChoice = 0
    
    var numberOfQuestions: Int {
        if let number = Int(NumberOfQuestions.allCases[numberOfQuestionsChoice].rawValue) {
            if number < maxNumberOfQuestions {
                return number
            } else {
                return maxNumberOfQuestions
            }
        }
        return maxNumberOfQuestions
    }
    
    var maxNumberOfQuestions: Int {
        timesUpTo * timesUpTo
    }
}
