//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Lorand Fazakas on 2021. 06. 03..
//

import SwiftUI
import CoreData

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsIgnoreCase = "CONTAINS[c]"
    case endsWith = "ENDSWITH"
    case endsWithIgnoreCase = "ENDSWITH[c]"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, predicate: Predicate = .beginsWith, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

