//
//  UserData.swift
//  MilestoneProject_9-12
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import Foundation
import CoreData

struct UserData {
    
    static func fetch(completion: @escaping ([UserDTO]) -> ()) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedUsers = try? JSONDecoder().decode([UserDTO].self, from: data) {
                completion(decodedUsers)
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
    static func load(moc: NSManagedObjectContext) {
        DispatchQueue.global().async {
            fetch { userDTOs in
                var users = [User]()
                for userDTO in userDTOs {
                    let user = User(context: moc)
                    user.id = userDTO.id
                    user.name = userDTO.name
                    user.about = userDTO.about
                    user.company = userDTO.company
                    user.age = Int16(userDTO.age)
                    user.email = userDTO.email
                    user.address = userDTO.address
                    user.tags = userDTO.tags
                    user.isActive = userDTO.isActive
                    user.registered = userDTO.registered
                    users.append(user)
                }
                
                for userDTO in userDTOs {
                    if let foundUser = users.first(where: { $0.id == userDTO.id}) {
                        for friend in userDTO.friends {
                            if let foundFriend = users.first(where: { $0.id == friend.id }) {
                                foundUser.addToFriends(foundFriend)
                            }
                        }
                    }
                }
                
                try? moc.save()
            }
        }
    }
}
