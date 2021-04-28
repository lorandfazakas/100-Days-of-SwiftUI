//
//  SettingsView.swift
//  MultiplicationTableEdutainment
//
//  Created by Lorand Fazakas on 2021. 04. 25..
//

import SwiftUI

struct SettingsView: View {
    @Binding var multiplicationTableSelection: Int
    @Binding var numberOfQuestions: NumberOfQuestionOptions
    @Binding var gameMode: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Image("owl")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: .center)
                    Spacer()
                    Form {
                        Section(header: Text("Which multiplication table you want to practice?")) {
                            Stepper(value: $multiplicationTableSelection, in: 1...12) {
                                Text("\(multiplicationTableSelection)")
                            }
                        }
                        Section(header: Text("How many questions you want to be asked?")) {
                            Picker("Questions", selection: $numberOfQuestions) {
                                ForEach(NumberOfQuestionOptions.allCases) { option in
                                    Text("\(option.rawValue)")
                                        .tag(option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Button(action: {
                            gameMode = true
                        }, label: {
                            Text("Start")
                        })
                    }.navigationBarTitle("Settings")
                }
            }
            
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(multiplicationTableSelection: .constant(5), numberOfQuestions: .constant(NumberOfQuestionOptions.ten), gameMode: .constant(false))
    }
}
