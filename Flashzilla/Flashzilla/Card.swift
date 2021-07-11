//
//  Card.swift
//  Flashzilla
//
//  Created by Lorand Fazakas on 2021. 07. 06..
//

import Foundation

struct Card: Codable, Identifiable {
    let prompt: String
    var answer: String
    let id = UUID()
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
