//
//  MapView.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 07. 01..
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var annotation: MKPointAnnotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let annotation = annotation {
            mapView.setCenter(annotation.coordinate, animated: true)
        }
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if let annotation = annotation {
            view.removeAnnotations(view.annotations)
            view.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Place"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
    }
    
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
           let annotation = MKPointAnnotation()
           annotation.title = "London"
           annotation.subtitle = "Home to the 2012 Summer Olympics."
           annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
           return annotation
       }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotation: MKPointAnnotation.example)
    }
}

