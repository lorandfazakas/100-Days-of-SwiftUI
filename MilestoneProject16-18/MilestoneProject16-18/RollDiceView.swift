//
//  RollDiceView.swift
//  MilestoneProject16-18
//
//  Created by Lorand Fazakas on 2021. 07. 13..
//

import SwiftUI

struct RollDiceView: View {
    @State private var rolledFaces: [DiceRoll.Face] = [.one, .one, .one, .one, .one]
    @ObservedObject var diceRollGame: DiceRollGame
    @State private var numberOfDice = 5
    
    var total: Int {
        rolledFaces.reduce(0) { $0 + $1.rawValue }
    }
    
    var body: some View {
        VStack {
            ForEach(rolledFaces, id: \.self) { face in
                Image(systemName: "die.face.\(face.rawValue).fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .onTapGesture(perform: rollDice)
            }
            
            Spacer()
            Form {
                Stepper(value: $numberOfDice, in: 1...5) {
                    Text("\(numberOfDice) dice")
                }
                Button("Roll", action: rollDice)
                Section {
                    Text("Total: \(total)")
                }
            }
            .frame(height: 250)
        }
    }
    
    func rollDice() {
        rolledFaces = []
        for _ in 0..<numberOfDice {
            rolledFaces.append(DiceRoll.Face.allCases.randomElement()!)
        }
        let rollResult = DiceRoll(result: rolledFaces, timestamp: Date())
        diceRollGame.add(rollResult)
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView(diceRollGame: DiceRollGame())
    }
}
