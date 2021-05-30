//
//  ContentView.swift
//  Habitify
//
//  Created by Lorand Fazakas on 2021. 05. 27..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activities.list) { activity in
                        NavigationLink(destination: ActivityDetailView(activities: activities, activityId: activity.id)){
                            Text(activity.title)
                        }
                    }
                    .onDelete(perform: removeActivity)
                    
                }
            }
            .navigationBarTitle("Activities")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddActivity = true
                }) {
                    Image(systemName: "plus")
                }
        )
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView(activities: self.activities)
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        activities.list.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: Activities())
    }
}
