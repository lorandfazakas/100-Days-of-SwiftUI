//
//  Mission.swift
//  Moonshot
//
//  Created by Lorand Fazakas on 2021. 05. 02..
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrewName: String {
        var matches = [Astronaut]()
        for member in crew {
            if let match = Astronauts.list.first(where: { $0.id == member.name }) {
                matches.append(match)
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        return (matches.map{$0.name}).joined(separator: ", ")
    }
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
