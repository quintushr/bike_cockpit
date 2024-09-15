//
//  BikeCockpitView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct BikeCockpitView: View {
    @State private var distanceLeft: Double = 120.0
    let maxSpeed: Double = 50.0  // Maximum speed for the circle
    let markerStep: Double = 2.5  // Interval for markers in km/h
    @State private var lineWidth = CGFloat(15)
    @ObservedObject var speedManager = SpeedManager()
    @ObservedObject var dateTimeManager = DateTimeManager()  // Use the DateTime manager
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Display formatted date and time
            Text("\(dateTimeManager.dateFormatter.string(from: dateTimeManager.currentDate))")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Spacer()
            
            // Circle showing the speed
            SpeedCircleView(speed: speedManager.speed, maxSpeed: maxSpeed, lineWidth: lineWidth)
            
            Spacer()
            
            Spacer()
            
            // Distance traveled and settings button
            BottomControlsView(distance: speedManager.totalDistance)
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct BikeCockpitView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCockpitView()
    }
}

