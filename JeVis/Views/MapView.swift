//
//  MapView.swift
//  JeVis
//
//  Created by Haliza Syafa Oktaviani on 28/04/24.
//

import SwiftUI
import MapKit
import UIKit

struct ContentView: View {

    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        
        Map(position: $cameraPosition){
            Annotation("Location", coordinate: .userLocation){
                ZStack{
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/.opacity(0.25))
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        
    }
}

extension CLLocationCoordinate2D{
    static var userLocation: CLLocationCoordinate2D{
        return .init(latitude: -7.607778, longitude: 110.203611)
    }
}

extension MKCoordinateRegion{
    static var userRegion: MKCoordinateRegion{
        return .init(center: .userLocation,
                     latitudinalMeters: 1000,
                     longitudinalMeters: 1000)
    }
}

#Preview {
    ContentView()
}

