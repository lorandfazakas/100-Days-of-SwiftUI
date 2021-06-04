//
//  UserDetailView.swift
//  MilestoneProject_9-12
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject var userData: UserData
    var user: User
    
    var body: some View {
        Form {
            Section {
                Text("Name: \(user.name)")
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
            }
            Section(header: Text("Contact")) {
                Text("Address: \(user.address)")
                Text("Email: \(user.email)")
            }
            Section(header: Text("Friends")) {
                List(user.friends) { friend in
                    if let foundFriend = userData.users.first(where: {$0.id == friend.id}) {
                        NavigationLink(destination: UserDetailView(userData: userData, user: foundFriend)) {
                            Text(friend.name)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("User details", displayMode: .inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(userData: UserData(), user: User(id: "4214-4214-221", isActive: true, name: "Dummy", age: 26, company: "Dummy Company", email: "dummy@mail.com", address: "Dummy Street 23", about: "Nothing about dummy", registered: "2019-12-12", tags: [], friends: []))
    }
}
