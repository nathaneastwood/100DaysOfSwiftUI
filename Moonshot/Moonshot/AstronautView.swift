//
//  AstronautView.swift
//  Moonshot
//
//  Created by Nathan Eastwood on 21/06/2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var astronautMissions = [Mission]()
    
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
                        .layoutPriority(1) // This allows all of the description to be given enough room to print
                    
                    Text("Missions")
                        .font(.headline)
                    
                    ForEach(astronautMissions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width * 0.3)
                                .padding()
                            VStack(alignment: .leading) {
                                Text("\(mission.displayName)")
                                Text("Launch date: \(mission.formattedLaunchDate)")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        .onAppear(perform: matchMissions)
    }
    
    func matchMissions() {
        for mission in missions {
            for member in mission.crew {
                if self.astronaut.id == member.name {
                    astronautMissions.append(mission)
                }
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
