//
//  SettingsView.swift
//  Edutainment
//
//  Created by Nathan Eastwood on 12/06/2021.
//

import SwiftUI

struct SettingsView: View {
        
    // Number of questions settings
    @State private var numberOfQuestions = ["5", "10", "20", "All"]
    
    // Should the settings view be displayed?
    @ObservedObject var settingsToggle = SettingsToggle()
    
    @ObservedObject var settings = Settings()
        
    var body: some View {
        VStack {
            Form {
                Section(
                    header:
                        Text("Test times tables up to:")
                        .foregroundColor(.orange)
                ) {
                    Stepper(value: $settings.timesUpTo, in: 1...12, step: 1) {
                        Text("\(settings.timesUpTo)")
                            .foregroundColor(.purple)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding()
                }
                
                Section(
                    header:
                        Text("Number of questions:")
                        .foregroundColor(.orange)
                ) {
                    Picker("Number of questions", selection: $settings.numberOfQuestionsChoice) {
                        ForEach(0..<numberOfQuestions.count, id: \Int.self) { choice in
                            Text("\(numberOfQuestions[choice] == "All" ? "All (" + String(settings.maxNumberOfQuestions) + ")" : numberOfQuestions[choice])")
                                .foregroundColor(.purple)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Button(action: {
                self.settingsToggle.isSettingsDisplayed.toggle()
            }) {
                Text("Let's Play!")
                    .font(.title)
                    .frame(width: 200, height: 100)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
