//
//  SpeedManager.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//


import Foundation
import CoreLocation
import SwiftUI

class SpeedManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    @Published var speed: Double = 0.0
    @Published var totalDistance: Double = 0.0  // Total distance traveled in kilometers
    
    private var lastLocation: CLLocation?  // Stores the last known location
    private var speedHistory: [Double] = []  // History of speeds for smoothing
    private let smoothingFactor = 5  // Number of points to use for smoothing the speed
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        // Configure the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // Maximum accuracy
        locationManager.activityType = .fitness
        locationManager.startUpdatingLocation() // Start getting location updates
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 5 // Update every 5 meters
    }
    
    // Function called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Calculate raw speed (in km/h)
            let rawSpeed = max(0, location.speed * 3.6)  // Convert m/s -> km/h, avoid negative speeds
            
            // Add to the history for smoothing
            speedHistory.append(rawSpeed)
            
            // Limit the history size (to avoid infinite accumulation)
            if speedHistory.count > smoothingFactor {
                speedHistory.removeFirst()
            }
            
            // Calculate the smoothed speed using moving average
            speed = speedHistory.reduce(0, +) / Double(speedHistory.count)
            
            // Calculate the distance traveled
            if let lastLocation = lastLocation {
                let distance = location.distance(from: lastLocation) / 1000.0  // Distance in kilometers
                totalDistance += distance
            }
            
            // Update the last known location
            lastLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
