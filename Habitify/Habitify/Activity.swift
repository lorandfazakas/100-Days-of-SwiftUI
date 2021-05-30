//
//  Activity.swift
//  Habitify
//
//  Created by Lorand Fazakas on 2021. 05. 27..
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var numberOfCompletion = 0
    
    mutating func complete() {
        self.numberOfCompletion += 1
    }
}
