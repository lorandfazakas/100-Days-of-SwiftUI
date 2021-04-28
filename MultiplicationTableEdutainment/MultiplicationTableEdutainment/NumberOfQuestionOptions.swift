//
//  NumberOfQuestionOptions.swift
//  MultiplicationTableEdutainment
//
//  Created by Lorand Fazakas on 2021. 04. 27..
//

import Foundation

enum NumberOfQuestionOptions: String, CaseIterable, Identifiable {
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case all = "All"
    
    var id: String { self.rawValue }
}
