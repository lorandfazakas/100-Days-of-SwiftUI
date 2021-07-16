//
//  DiceRollGame.swift
//  MilestoneProject16-18
//
//  Created by Lorand Fazakas on 2021. 07. 15..
//

import Foundation

class DiceRollGame: ObservableObject {
    @Published private(set) var rolls: [DiceRoll]
    static let saveKey = "DiceRolls"
    
    init() {
        let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        do {
            let data = try Data(contentsOf: filename)
            rolls = try JSONDecoder().decode([DiceRoll].self, from: data)
        } catch {
            rolls = []
            print("Unable to load saved data.")
        }
    }
    
    func add(_ roll: DiceRoll) {
        rolls.append(roll)
        save()
    }
    
    private func save() {
        do {
            let filename = Self.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(self.rolls)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
