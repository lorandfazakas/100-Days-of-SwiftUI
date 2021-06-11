//
//  MilestoneProject10_12App.swift
//  MilestoneProject10-12
//
//  Created by Lorand Fazakas on 2021. 06. 04..
//

import SwiftUI

@main
struct MilestoneProject10_12App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
