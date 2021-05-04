//
//  ContentView.swift
//  Moonshot
//
//  Created by Lorand Fazakas on 2021. 05. 02..
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLaunchDate = true
    
    var body: some View {
        NavigationView {
            List(Missions.list) { mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    Image(mission.image)
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showLaunchDate ? mission.formattedLaunchDate : mission.formattedCrewName)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: toggleDetails)
            {
                Text(showLaunchDate ? "Show Crew Names" : "Show Launch Date")
            })
            
        }
    }
    
    func toggleDetails() {
        showLaunchDate.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
