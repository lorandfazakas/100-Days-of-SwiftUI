//
//  UserDetailView.swift
//  MilestoneProject_9-12
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import SwiftUI

struct UserDetailView: View {
    
    var user: User
    
    var body: some View {
        Form {
            Section {
                Text("Name: \(user.wrappedName)")
                Text("Age: \(user.age)")
                Text("Company: \(user.wrappedCompany)")
            }
            Section(header: Text("Contact")) {
                Text("Address: \(user.wrappedAddress)")
                Text("Email: \(user.wrappedEmail)")
            }
            Section(header: Text("Friends")) {
                List(user.wrappedFriends) { friend in
                    NavigationLink(destination: UserDetailView(user: friend)) {
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationBarTitle("User details", displayMode: .inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var user: User {
        let user = User()
        user.name = "John Doe"
        user.age = 25
        user.company = "Starbucks"
        return user
    }
    
    static var previews: some View {
        UserDetailView(user: user)
    }
}
