//
//  ContentView.swift
//  VolumeConversion
//
//  Created by Nathan Eastwood on 24/05/2021.
//

// You need to build an app that handles unit conversions:
// users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
// Volume conversion: users choose milliliters, liters, cups, pints, or gallons.

import SwiftUI

struct ContentView: View {
    
    @State private var inputAmount = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let unitType = ["mL", "L", "C", "pt", "gal"]
    
    let numberConversion = ["mL" : 1, "L" : 1000, "C" : 284.1306, "pt" : 568.2613, "gal" : 4546.09]
    
    func convertAmount() -> Double {
        let toConvert = Double(inputAmount) ?? 0
        let chosenInUnit = unitType[inputUnit]
        let chosenOutUnit = unitType[outputUnit]
        let conversionMultiplier = numberConversion[chosenInUnit] ?? 1.0
        let conversionDenominator = numberConversion[chosenOutUnit] ?? 1.0
        return (toConvert * conversionMultiplier) / conversionDenominator
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How much do you want to convert?")) {
                    TextField("Amount", text: $inputAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("What unit are you converting from?")) {
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(0 ..< unitType.count) {
                            Text("\(self.unitType[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("What unit do you want to convert to?")) {
                    Picker("Convert from", selection: $outputUnit) {
                        ForEach(0 ..< unitType.count) {
                            Text("\(self.unitType[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("The converted amount is:")) {
                    Text("\(convertAmount(), specifier: "%.3f")").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarTitle("VolumeConversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
