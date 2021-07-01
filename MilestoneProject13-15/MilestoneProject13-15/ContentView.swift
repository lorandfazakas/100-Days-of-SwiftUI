//
//  ContentView.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 06. 27..
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddPersonView = false
    @State private var persons = [Person]()
    
    var body: some View {
        NavigationView {
            List(persons.sorted()) { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
                        Text(person.name)
                        Spacer()
                        getImage(for: person)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                    }
            }
            .navigationBarTitle("People")
            .navigationBarItems(trailing: Button(action: {
                showingAddPersonView = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddPersonView) {
            AddPersonView(persons: $persons)
        }
        .onAppear(perform: loadData)
        
    }
    
    func getImage(for person: Person) -> Image {
        if let data = person.imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.crop.circle")
    }
    
    func loadData() {
        let filename = ImageUtil.getDocumentsDirectory().appendingPathComponent("Persons")
        do {
            let data = try Data(contentsOf: filename)
            persons = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

