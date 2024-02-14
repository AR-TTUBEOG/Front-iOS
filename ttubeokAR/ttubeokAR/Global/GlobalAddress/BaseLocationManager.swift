//
//  TestLo.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import Foundation
import CoreLocation

class BaseLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = BaseLocationManager()

    private let locationManager = CLLocationManager()
    var onAuthorizationChanged: ((CLAuthorizationStatus) -> Void)?
    @Published var currentLocation: CLLocation?
    @Published var estimatedTime: TimeInterval = 0
    @Published var distance: CLLocationDistance = 0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        onAuthorizationChanged?(status)
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManger: \(error)")
    }
}
