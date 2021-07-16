//
//  ContentView.swift
//  MilestoneProject16-18
//
//  Created by Lorand Fazakas on 2021. 07. 13..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var diceRollGame = DiceRollGame()
    
    var body: some View {
        TabView {
            RollDiceView(diceRollGame: diceRollGame)
                .tabItem {
                    Image(systemName: "die.face.5")
                    Text("Roll Die")
                }
            ResultsView(diceRollGame: diceRollGame)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Results")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
