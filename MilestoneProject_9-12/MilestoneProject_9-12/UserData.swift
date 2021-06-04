//
//  UserData.swift
//  MilestoneProject_9-12
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import Foundation

class UserData: ObservableObject, Codable {
    @Published var users = [User]()
    
    enum CodingKeys: CodingKey {
        case users
    }
    
    init() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.users = decodedUsers
                }
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        users = try container.decode([User].self, forKey: .users)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(users, forKey: .users)
    }
}
