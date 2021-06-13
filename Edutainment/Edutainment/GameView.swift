//
//  GameView.swift
//  Edutainment
//
//  Created by Nathan Eastwood on 12/06/2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var settingsToggle = SettingsToggle()
    @ObservedObject var settings = Settings()
    
    @State private var questions = [Question]()
    @State private var gameInProgress = false
    
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var score = 0
    @State private var percent = 0
    
    @State private var thumb = ""
    @State private var thumbOpacity = 1.0
    @State private var thumbColor = Color.green
    
    var body: some View {
        VStack(alignment: .center) {
            if gameInProgress {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Text(questions[currentQuestion].question)
                        .fontWeight(.black)
                        .frame(width: 200, alignment: .trailing)
                        .foregroundColor(.purple)
                    TextField("?", text: $answer, onCommit: checkAnswer)
                        .keyboardType(.numberPad)
                        .frame(width: 200, alignment: .leading)
                    Spacer()
                }
                .font(.largeTitle)
                .padding()
                Image(systemName: thumb)
                    .frame(width: 75, height: 75)
                    .foregroundColor(thumbColor)
                    .opacity(thumbOpacity)
                    .animation(.easeInOut(duration: 1))
                Spacer()
                Text("Your score is: \(score) / \(settings.numberOfQuestions)")
                    .font(.title)
            } else {
                Spacer()
                if currentQuestion >= settings.numberOfQuestions {
                    Text("You scored \(score) / \(settings.numberOfQuestions)")
                        .fontWeight(.black)
                        .font(.largeTitle)
                        .foregroundColor(Double(score) / Double(settings.numberOfQuestions) < 0.5 ? .red : .green)
                    if Double(score) / Double(settings.numberOfQuestions) < 0.5 {
                        Text("Keep practicing!")
                            .font(.title)
                    } else {
                        Text("Great work!")
                            .font(.title)
                    }
                }
                Spacer()
                NewGameButton(settingsToggle: settingsToggle)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .onAppear(perform: generateQuestions)
        .navigationBarItems(
            leading: gameInProgress ?
                NewGameButton(settingsToggle: settingsToggle)
                  .foregroundColor(.yellow) :
                nil,
            trailing: gameInProgress ? Text("Question: \(currentQuestion)/\(String(settings.numberOfQuestions))") : nil
        )
    }
    
    func generateQuestions() {
        questions = Questions(timesUpTo: settings.timesUpTo, numberOfQuestions: settings.numberOfQuestions).questions
        gameInProgress = true
        currentQuestion = 0
    }
    
    func checkAnswer() {
        if questions[currentQuestion].answer == answer {
            score += 1
            thumb = "hand.thumbsup.fill"
            thumbColor = Color.green
        } else {
            thumb = "hand.thumbsdown.fill"
            thumbColor = Color.red
        }
        withAnimation {
            self.thumbOpacity = 1.0
        }
        currentQuestion += 1
        answer = ""
        thumbOpacity = 0.0
        if currentQuestion >= settings.numberOfQuestions {
            gameInProgress = false
        }
    }
}

struct NewGameButton: View {
    @ObservedObject var settingsToggle = SettingsToggle()
    
    var body: some View {
        Button("New Game") {
            self.settingsToggle.isSettingsDisplayed.toggle()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .padding()
    }
}
