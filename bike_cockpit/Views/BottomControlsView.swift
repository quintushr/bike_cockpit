//
//  BottomControlsView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct BottomControlsView: View {
    let distanceUnit: String
    @ObservedObject var speedManager: SpeedManager  // Pass the speedManager object
    
    var body: some View {
        HStack {
            // Distance traveled
            Text("\(String(format: "%.1f", convertedDistance)) \(distanceUnit)")
                .font(.title)
                .foregroundColor(.white)

            Spacer()

            // Button to trigger settings view with smooth transition
            NavigationLink( destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())  // Circular button
                    .shadow(radius: 10)
            }
            .frame(width: 60, height: 60)  // Button size
        }
        .padding(.horizontal, 30)
    }
    
    // Computed property to convert distance based on selected unit
    var convertedDistance: Double {
        if distanceUnit == "mi" {
            return speedManager.totalDistance * 0.621371  // Convert km to miles
        } else {
            return speedManager.totalDistance  // Default to km
        }
    }
}


