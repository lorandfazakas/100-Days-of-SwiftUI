//
//  ContentView.swift
//  MilestoneProject10-12
//
//  Created by Lorand Fazakas on 2021. 06. 04..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Text("\(user.wrappedName), \(user.age)" )
                    }
                }
            }
            .navigationBarTitle("Users")
            .onAppear(perform: loadUsers)
        }
    }
    
    func loadUsers() {
        if users.isEmpty {
            UserData.load(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
