//
//  GameView.swift
//  MultiplicationTableEdutainment
//
//  Created by Lorand Fazakas on 2021. 04. 25..
//

import SwiftUI

struct GameView: View {
    
    @Binding var gameMode: Bool
    private var questions = [Question]()
    private var numberOfQuestions: Int
    
    @State private var currentQuestion = 0
    @State private var answer: String = ""
    @State private var score: Int = 0
    @State private var animalFace: String = animalImages.randomElement()!
    @State private var showingScore = false
    
    private static var animalImages = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog",
    "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig",
    "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(animalFace)
                Text(questions[currentQuestion].question)
                    .font(.title)
                TextField("Answer", text: $answer, onCommit: evaluateAnswer)
                    .padding()
                    .keyboardType(.numberPad)
                Text("Score: \(score)")
                Button(action: endGame, label: {
                    Text("Retry")
                })
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Great Job"), message: Text("Your score is \(score) out of \(numberOfQuestions)."), dismissButton: .default(Text("Continue")) {
                self.endGame()
            })
        }
        
    }
    
    func endGame() {
        gameMode = false
    }
    
    func evaluateAnswer() {
        let answerInt = Int(answer) ?? 0
        score += answerInt == questions[currentQuestion].answer ? 1 : 0
        answer = ""
        currentQuestion += 1
        if (currentQuestion == numberOfQuestions) {
            showingScore = true
            return
        }
        animalFace = GameView.animalImages.randomElement()!
    }
    
    init(gameMode: Binding<Bool>, selectedNumber: Int, numberOfQuestions: NumberOfQuestionOptions) {
        self._gameMode = gameMode
        for i in 1...12 {
            questions.append(Question(id: i, question: "How much is \(i) * \(selectedNumber)?", answer: i * selectedNumber))
            questions.append(Question(id: i*2, question: "How much is \(selectedNumber) * \(i)?", answer: i * selectedNumber))
        }
        questions.shuffle()
        self.numberOfQuestions = numberOfQuestions == NumberOfQuestionOptions.all ? questions.count : Int(numberOfQuestions.rawValue)!
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameMode: .constant(true), selectedNumber: 5, numberOfQuestions: NumberOfQuestionOptions.five)
    }
}
