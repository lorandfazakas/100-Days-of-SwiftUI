//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lorand Fazakas on 2021. 04. 11..
//

import SwiftUI

struct ContentView: View {
    private var moves = ["✊", "✋", "✌️"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turnCounter = 1
    @State private var showScore = false
    
    var body: some View {
        VStack {
            Text("Turn \(turnCounter)")
            Text("App's move: \(moves[appChoice])")
                .font(.largeTitle)
                .padding()
            Text("Player should \(shouldWin ? "Win" : "Lose")")
                .padding()
            ForEach(moves, id: \.self) { move in
                Button(action: {
                    playerChoseMove(move: move)
                    
                }) {
                    Text(move)
                        .font(.title)
                }
            }
        }
        .alert(isPresented: $showScore){
            Alert(title: Text("End of the game"), message: Text("Your score is \(score)."), dismissButton: .default(Text("Ok")) {
                self.newGame()
            })
        }
    }

    
    func playerChoseMove(move: String) {
        score += evaluateResult(move: move) ? 1 : -1
        turnCounter == 10 ? showScore = true : newMove()
    }
    
    func newGame() {
        turnCounter = 0
        score = 0
        newMove()
    }
    
    func newMove() {
        turnCounter += 1
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func evaluateResult(move: String) -> Bool {
        let offset = shouldWin ? 1 : 2
        return move == moves[(appChoice+offset)%moves.count]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
