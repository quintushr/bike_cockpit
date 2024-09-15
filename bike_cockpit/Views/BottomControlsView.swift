//
//  BottomControlsView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct BottomControlsView: View {
    let distance: Double
    
    var body: some View {
        HStack {
            // Distance traveled
            Text("\(String(format: "%.1f", distance)) km")
                .font(.title)
                .foregroundColor(.white)
            
            Spacer()
            
            // Settings button without text
            Button(action: {
                // Action when the settings button is pressed
                print("Settings button pressed")
            }) {
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
}

