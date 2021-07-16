//
//  DiceRoll.swift
//  MilestoneProject16-18
//
//  Created by Lorand Fazakas on 2021. 07. 13..
//

import Foundation

struct DiceRoll: Codable, Identifiable {
    var result: [Face]
    var timestamp: Date
    var id = UUID()
    
    enum Face: Int, Codable, CaseIterable {
        case one = 1, two, three, four, five, six
    }
}


