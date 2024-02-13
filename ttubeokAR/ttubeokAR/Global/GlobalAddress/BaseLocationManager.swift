//
//  TestLo.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import Foundation
import CoreLocation

class BaseLocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = BaseLocationManager()

    private let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var onAuthorizationChanged: ((CLAuthorizationStatus) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        currentLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManger: \(error)")
    }
}
