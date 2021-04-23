//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lorand Fazakas on 2021. 04. 04..
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var rotatingAnimationAmounts = [0.0, 0.0, 0.0]
    @State var animateFade = false
    @State var shakeAnimationAmounts = [0, 0, 0]
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(rotatingAnimationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.animateFade ? (number == self.correctAnswer ? 1 : 0.25) : 1)
                    .modifier(ShakeEffect(shakes: self.shakeAnimationAmounts[number] * 2))
                }
                Text("Score: \(score)").foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)."), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation(.easeIn(duration: 0.5)) {
            animateFade = true
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation(.easeInOut(duration: 2)) {
                rotatingAnimationAmounts[number] += 360
            }
        } else {
            scoreTitle = "Wrong. Thats the flag of \(countries[number])"
            score -= 1
            withAnimation(Animation.easeInOut(duration: 1)) {
                self.shakeAnimationAmounts[number] = 2
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotatingAnimationAmounts = [0.0, 0.0, 0.0]
        shakeAnimationAmounts = [0, 0, 0]
        animateFade = false
    }
}

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
