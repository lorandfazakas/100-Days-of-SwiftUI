//
//  ContentView.swift
//  Flashzilla
//
//  Created by Lorand Fazakas on 2021. 07. 06..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingSheet = false
    @State private var isActive = true
    
    @State private var activeSheet = ActiveSheet.settings
    @State private var doRetryIncorrectCards = false
    @State private var showingTimesUpAlert = false
    
    enum ActiveSheet {
        case settings, edit
    }
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card,  retryEnabled: self.doRetryIncorrectCards) { isCorrect in
                            if isCorrect {
                                
                            } else {
                                if doRetryIncorrectCards {
                                    self.putBackCard(at: index(for: card))
                                    return
                                }
                            }
                            withAnimation {
                                self.removeCard(at: index(for: card))
                            }
                        }
                        .stacked(at: index(for: card), in: self.cards.count)
                        .allowsHitTesting(index(for: card) == self.cards.count - 1)
                        .accessibility(hidden: index(for: card) < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Button(action: {
                        self.showingSheet = true
                        self.activeSheet = ActiveSheet.settings
                    }) {
                        Image(systemName: "gearshape")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingSheet = true
                        self.activeSheet = ActiveSheet.edit
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
                
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            if doRetryIncorrectCards {
                                self.putBackCard(at: self.cards.count - 1)
                                
                            } else {
                                withAnimation {
                                    self.removeCard(at: self.cards.count - 1)
                                }
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                        
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                showingTimesUpAlert = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            switch activeSheet {
            case .edit:
                EditCards()
            case .settings:
                SettingsView(doRetryIncorrectCards: $doRetryIncorrectCards)
            }
            
        }
        .alert(isPresented: $showingTimesUpAlert) {
            Alert(title: Text("Time's Up"), message: Text("You have no time left."), dismissButton: .default(Text("Try Again")){
                resetCards()
            })
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else {return}
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func putBackCard(at index: Int) {
        guard index >= 0 else {return}
        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
