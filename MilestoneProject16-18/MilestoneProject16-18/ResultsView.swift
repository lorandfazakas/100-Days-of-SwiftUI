//
//  ResultsView.swift
//  MilestoneProject16-18
//
//  Created by Lorand Fazakas on 2021. 07. 13..
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var diceRollGame: DiceRollGame
    
    var body: some View {
        List(diceRollGame.rolls) { roll in
            HStack {
                ForEach(roll.result, id: \.self) { face in
                    Image(systemName: "die.face.\(face.rawValue).fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                
                Spacer()
                Text(getFormattedDate(for: roll.timestamp))
            }
        }
    }
    
    func getFormattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(diceRollGame: DiceRollGame())
    }
}
