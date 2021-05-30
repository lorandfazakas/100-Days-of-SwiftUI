//
//  Activities.swift
//  Habitify
//
//  Created by Lorand Fazakas on 2021. 05. 27..
//

import Foundation

class Activities: ObservableObject {
    @Published var list: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(list) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.list = decoded
                return
            }
        }
        self.list = []
    }
    
    func firstMatchIndex(id: UUID) -> Int? {
        list.firstIndex(where: {$0.id == id})
    }
    
    func complete(id: UUID) {
        guard let activityIndex = firstMatchIndex(id: id) else {return}
        list[activityIndex].complete()
    }
}
