//
//  AddActivityView.swift
//  Habitify
//
//  Created by Lorand Fazakas on 2021. 05. 29..
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing:
                Button("Save") {
                    let activity = Activity(title: self.title, description: self.description)
                    self.activities.list.append(activity)
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
