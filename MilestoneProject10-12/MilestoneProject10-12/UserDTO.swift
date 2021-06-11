//
//  UserDTO.swift
//  MilestoneProject10-12
//
//  Created by Lorand Fazakas on 2021. 06. 04..
//

import Foundation

struct UserDTO: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [FriendDTO]
}
