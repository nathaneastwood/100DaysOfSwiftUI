//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nathan Eastwood on 24/05/2021.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount: CGFloat = 1.0
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.black, .blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) {number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: correctAnswer == number ? 1 : 0, z: 0))
                            .animation(Animation.easeOut)
                            .opacity(correctAnswer != number ? opacityAmount : 1.0)
                            .animation(Animation.easeOut)
                            .scaleEffect(correctAnswer != number ? scaleAmount : 1.0)
                            .animation(.default)
                    }
                    
                }
                
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
                    .font(.title)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is \(userScore)"),
                dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                }
            )
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            withAnimation {
                animationAmount += 360
                opacityAmount = 0.25
            }
            animationAmount = 0.0
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            withAnimation {
                scaleAmount = 0.5
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
