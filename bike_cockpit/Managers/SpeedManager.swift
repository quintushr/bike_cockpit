//
//  SpeedManager.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//


import Foundation
import CoreLocation
import SwiftUI

import SwiftUI
import CoreLocation

class SpeedManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    @Published var speed: Double = 0.0
    @Published var totalDistance: Double = 0.0  // Total distance traveled in kilometers
    
    private var lastLocation: CLLocation?  // Stores the last known location
    private var speedHistory: [Double] = []  // History of speeds for smoothing
    private let smoothingFactor = 5  // Number of points to use for smoothing the speed
    
    // AppStorage to store min and max speed bounds
    @AppStorage("minCyclingSpeed") var minCyclingSpeed: Double = 9.0
    @AppStorage("maxCyclingSpeed") var maxCyclingSpeed: Double = 40.0
    
    // Key for UserDefaults to store the total distance
    private let totalDistanceKey = "totalDistance"

    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        // Load the stored total distance from UserDefaults when the manager is initialized
        totalDistance = UserDefaults.standard.double(forKey: totalDistanceKey)
        
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
            
            // Calculate the distance traveled if the speed is within the user-defined range
            if speed >= minCyclingSpeed && speed <= maxCyclingSpeed {
                if let lastLocation = lastLocation {
                    let distance = location.distance(from: lastLocation) / 1000.0  // Distance in kilometers
                    totalDistance += distance
                }
            }
            
            // Update the last known location
            lastLocation = location
        }
    }
    
    // Function to reset total distance
    func resetTotalDistance() {
        totalDistance = 0.0
        UserDefaults.standard.set(totalDistance, forKey: totalDistanceKey)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
