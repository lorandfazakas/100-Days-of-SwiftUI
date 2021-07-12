//
//  MissionView.swift
//  Moonshot
//
//  Created by Lorand Fazakas on 2021. 05. 03..
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .scaleEffect(1 + geo.frame(in: .global).minY / 700)
                    }
                    .frame(maxWidth: fullView.size.width * 0.7 )
                    
                    Text(self.mission.formattedLaunchDate)
                        .padding()
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = Astronauts.list.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static var previews: some View {
        MissionView(mission: Missions.list[0])
    }
}
