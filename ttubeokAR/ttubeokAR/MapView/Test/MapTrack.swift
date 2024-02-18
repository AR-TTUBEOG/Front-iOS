//
//  MapTrack.swift
//  ttubeokAR
//
//  Created by Subeen on 2/16/24.
//

import SwiftUI
import MapKit

struct MapTrack: View {
    
    @State private var history: [CLLocationCoordinate2D] = []
    private var dest: CLLocation? = nil
    @State private var isTracking: Bool = false
    @State private var polyline = MKPolyline()
    @ObservedObject var locationManager = BaseLocationManager.shared
    
    @StateObject private var viewModel = RoadViewModel()
    
    @State private var position: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate:
                CLLocationCoordinate2D(
                    latitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.latitude ?? 0.0,
                    longitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.longitude ?? 0.0
                ),
            distance: 980,
            pitch: 80
        )
    )
    
    var body: some View {
        
        Map(position: $position) {
            UserAnnotation {
                Text("h")
            }
            
            MapPolyline(coordinates: viewModel.history ?? [])
                .stroke(.blue, lineWidth: 10.0)
        }
        .onReceive(locationManager.$currentLocation) { newLocation in
            guard let location = newLocation else { return }
            updatePolyline(with: location.coordinate)
            updateRegion(to: location.coordinate)
        }
        .onAppear {
            BaseLocationManager.shared.requestLocationAuthorization()
            
            BaseLocationManager.shared.startUpdatingLocation()
                
            _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                    if let currentLocation = BaseLocationManager.shared.getCurrentLocation() {
                        viewModel.history?.append(.init(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
                        print("\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
                    }
            }
            
            BaseLocationManager.shared.stopUpdatingLocation()
        }
    }
    
    private func updatePolyline(with coordinate: CLLocationCoordinate2D) {
        viewModel.history?.append(coordinate)
        polyline = MKPolyline(coordinates: viewModel.history ?? [], count: viewModel.history?.count ?? 0)
    }
    
    private func updateRegion(to coordinate: CLLocationCoordinate2D) {
        position = .camera(
            MapCamera(
                centerCoordinate:
                    CLLocationCoordinate2D(
                        latitude: coordinate.latitude ,
                        longitude: coordinate.longitude
                    ),
                distance: 980,
                pitch: 80
            )
        )
    }
}


#Preview {
    MapTrack()
}
