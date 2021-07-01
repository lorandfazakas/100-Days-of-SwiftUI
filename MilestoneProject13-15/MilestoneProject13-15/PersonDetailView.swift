//
//  PersonDetailView.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 06. 30..
//

import SwiftUI
import MapKit

struct PersonDetailView: View {
    @State private var tab = ViewState.image
    var person: Person
    var annotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        return annotation
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $tab) {
                Text("Image").tag(ViewState.image)
                Text("Location").tag(ViewState.location)
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            switch tab {
            case .image:
                getImage(for: person)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .navigationBarTitle(Text(person.name))
            case .location:
                MapView(annotation: annotation)
            }
        }
    }
    
    func getImage(for person: Person) -> Image {
        if let data = person.imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.crop.square")
    }
    
    enum ViewState {
        case image, location
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(name: "John Doe"))
    }
}
