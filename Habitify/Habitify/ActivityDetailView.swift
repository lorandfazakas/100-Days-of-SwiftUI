//
//  ActivityDetailView.swift
//  Habitify
//
//  Created by Lorand Fazakas on 2021. 05. 29..
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    var activityId: UUID
    
    var activityIndex: Int? {
        activities.firstMatchIndex(id: activityId)
    }
    
    var activity: Activity {
        activities.list[activityIndex ?? 0]
    }
    
    var body: some View {
        VStack {
            Text(activity.title)
                .padding()
                .font(.headline)
            Text(self.activity.description)
                .padding()
            Text("Number of completion: \(self.activity.numberOfCompletion)")
                .padding()
            Button(action: {
                activities.complete(id: activityId)
            }) {
                Text("Complete")
            }
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activityId: UUID())
    }
}
