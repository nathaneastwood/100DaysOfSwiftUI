//
//  ContentView.swift
//  Edutainment
//
//  Created by Nathan Eastwood on 12/06/2021.
//

import SwiftUI

class SettingsToggle: ObservableObject {
    @Published var isSettingsDisplayed = true
}

struct ContentView: View {
    
    @ObservedObject var settingsToggle = SettingsToggle()
    @ObservedObject var settings = Settings()
    
    var body: some View {
        NavigationView {
            Group {
                if settingsToggle.isSettingsDisplayed {
                    SettingsView(settingsToggle: settingsToggle, settings: settings)
                } else {
                    GameView(settingsToggle: settingsToggle, settings: settings)
                }
            }
            .navigationBarTitle("Edutainment")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
