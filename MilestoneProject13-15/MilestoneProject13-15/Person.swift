//
//  Person.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 06. 30..
//

import Foundation
import MapKit

struct Person: Identifiable, Codable, Comparable {
    var id = UUID()
    var name: String
    var latitude: Double = 0
    var longitude: Double = 0
    
    var imageURI: String {
        get {
            self.id.uuidString
        }
    }
    
    var imageData: Data? {
        if let data = try? Data(contentsOf: ImageUtil.getDocumentsDirectory().appendingPathComponent(imageURI)) {
            return data
        }
        return nil
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
}
