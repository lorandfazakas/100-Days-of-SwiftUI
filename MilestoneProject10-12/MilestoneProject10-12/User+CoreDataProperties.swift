//
//  User+CoreDataProperties.swift
//  MilestoneProject10-12
//
//  Created by Lorand Fazakas on 2021. 06. 04..
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    var wrappedId: String {
        id ?? "Unknown Id"
    }
    
    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    var wrappedEmail: String {
        email ?? "Unkwown email"
    }
    
    var wrappedAbout: String {
        about ?? "Unkown about"
    }
    
    var wrappedRegistered: String {
        registered ?? "Unknown registered"
    }
    
    var wrappedTags: [String] {
        tags ?? []
    }

    var wrappedFriends: [User] {
        let set = friends as? Set<User> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
