//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
