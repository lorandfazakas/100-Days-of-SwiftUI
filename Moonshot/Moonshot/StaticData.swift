//
//  StaticData.swift
//  Moonshot
//
//  Created by Lorand Fazakas on 2021. 05. 04..
//

import Foundation

struct Missions {
    static let list: [Mission] = Bundle.main.decode("missions.json")
}

struct Astronauts {
    static let list: [Astronaut] = Bundle.main.decode("astronauts.json")
}
