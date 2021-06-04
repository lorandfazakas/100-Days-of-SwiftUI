//
//  ContentView.swift
//  MilestoneProject_9-12
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.users) { user in
                    NavigationLink(destination: UserDetailView(userData: userData, user: user)) {
                        Text("\(user.name), \(user.age)" )
                    }
                }
            }
            .navigationBarTitle("Users")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
