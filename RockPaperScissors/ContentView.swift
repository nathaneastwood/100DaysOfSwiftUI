//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nathan Eastwood on 29/05/2021.
//

import SwiftUI

struct Move: View {
    var choice: String
    var body: some View {
        Text(choice)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .frame(width: 200, height: 100)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    
    @State private var possibleMoves = ["Rock", "Paper", "Scissors"]
    
    @State private var randomMove = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    
    @State private var questionNumber = 1
    @State private var userScore = 0
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Choose \(possibleMoves[randomMove].lowercased()) to \(shouldWin ? "win" : "lose")")
                .font(.largeTitle)
            
            ForEach(0 ..< possibleMoves.count) {number in
                Button(action: {
                    self.playerTapped(number)
                }) {
                    Move(choice: possibleMoves[number])
                }
            }
                        
        }
        .alert(isPresented: $showingScore, content: {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is \(userScore)"),
                dismissButton: .default(Text("Play again?")) {
                    self.resetGame()
                }
            )
        })
    }
    
    func playerTapped(_ number: Int) {
        if shouldWin {
            let correctAnswer = (randomMove - 1 == -1 ? 2 : randomMove - 1)
            if number == correctAnswer {
                userScore += 1
            }
        } else {
            let correctAnswer = (randomMove + 1 == 3 ? 0 : randomMove + 1)
            if number == correctAnswer {
                userScore += 1
            }
        }
        questionNumber += 1
        if questionNumber == 11 {
            showingScore = true
        } else {
            randomMove = Int.random(in: 0 ..< 3)
            shouldWin = Bool.random()
        }
    }
    
    func resetGame() {
        userScore = 0
        questionNumber = 1
        randomMove = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
