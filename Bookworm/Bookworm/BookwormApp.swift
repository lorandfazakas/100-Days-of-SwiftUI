//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Lorand Fazakas on 2021. 06. 02..
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
