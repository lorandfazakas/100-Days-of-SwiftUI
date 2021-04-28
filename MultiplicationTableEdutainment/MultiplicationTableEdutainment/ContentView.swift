//
//  ContentView.swift
//  MultiplicationTableEdutainment
//
//  Created by Lorand Fazakas on 2021. 04. 25..
//

import SwiftUI

struct ContentView: View {
    @State private var gameMode = false
    @State private var numberOfQuestions = NumberOfQuestionOptions.five
    @State private var multiplicationTableSelection = 5
    
    
    var body: some View {
        Group {
            if gameMode {
                GameView(gameMode: $gameMode, selectedNumber: multiplicationTableSelection, numberOfQuestions: numberOfQuestions)
            } else {
                SettingsView(multiplicationTableSelection: $multiplicationTableSelection, numberOfQuestions: $numberOfQuestions, gameMode: $gameMode)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
