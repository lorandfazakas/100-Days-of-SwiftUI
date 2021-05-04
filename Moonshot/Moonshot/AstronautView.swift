//
//  AstronautView.swift
//  Moonshot
//
//  Created by Lorand Fazakas on 2021. 05. 03..
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let participatedMissions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Participated in missions: ")
                        .font(.headline)
                    ForEach(participatedMissions) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 83, height: 60)
                            Text(mission.displayName)
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        self.participatedMissions = Missions.list.filter{ mission in
            for member in mission.crew {
                if member.name == astronaut.id {
                    return true
                }
            }
            return false
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
