//
//  ContentView.swift
//  ChallengeOne
//
//  Created by Lorand Fazakas on 2021. 04. 03..
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var inputUnit = 1
    @State private var outputUnit = 1
    private var result: Double {
        let inputMeasurement = Measurement(value: Double(amount) ?? 0, unit: lengthUnits[inputUnit])
        return inputMeasurement.converted(to: lengthUnits[outputUnit]).value
    }
    
    private var lengthUnits = [UnitLength.kilometers, UnitLength.meters, UnitLength.inches, UnitLength.yards, UnitLength.miles]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Input Unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<lengthUnits.count) {
                            Text(lengthUnits[$0].symbol)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output Unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0..<lengthUnits.count) {
                            Text(lengthUnits[$0].symbol)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(result, specifier: "%g")")
                }
            }.navigationTitle("Length conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
