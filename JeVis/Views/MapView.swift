//
//  MapView.swift
//  JeVis
//
//  Created by Haliza Syafa Oktaviani on 28/04/24.
//

import SwiftUI
import MapKit
import UIKit

//var locationModel: LocationModel = LocationModel(latitude: 51.50576400756836, longitude: -0.075251996517181, address: String)

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion(locationModel: nil))
    let locationModel: LocationModel?
    var defaultCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        
        Map(position: $cameraPosition){
            Annotation("Location", coordinate: .userLocation(locationModel: locationModel)){
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
        .onAppear {
            cameraPosition = .region(.userRegion(locationModel: locationModel))
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        
    }
}

extension CLLocationCoordinate2D{
    static func userLocation(locationModel: LocationModel?) -> CLLocationCoordinate2D{
        let latitude = locationModel?.latitude ?? -7.607778
        let longitude = locationModel?.longitude ?? 110.203611
        return .init(latitude: latitude, longitude: longitude)
    }
}

extension MKCoordinateRegion{
    static func userRegion(locationModel: LocationModel?) -> MKCoordinateRegion{
        return .init(center: .userLocation(locationModel: locationModel),
                     latitudinalMeters: 1000,
                     longitudinalMeters: 1000)
    }
}

#Preview {
    MapView(locationModel: LocationModel(latitude: -6.3031838, longitude: 106.652819))
}

