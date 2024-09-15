//
//  SettingsView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("speedUnit") var speedUnit: String = "km/h"
    @AppStorage("distanceUnit") var distanceUnit: String = "km"
    @AppStorage("speedCircleColorHex") var speedCircleColorHex: String = "#FFFFFF"
    
    @ObservedObject var speedManager = SpeedManager()


    let speedUnits = ["km/h", "mph"]
    let distanceUnits = ["km", "mi"]

    @State private var speedCircleColor: Color = Color.white

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Picker("Speed Unit", selection: $speedUnit) {
                ForEach(speedUnits, id: \.self) { unit in
                    Text(unit).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
            
            Picker("Distance Unit", selection: $distanceUnit) {
                ForEach(distanceUnits, id: \.self) { unit in
                    Text(unit).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
            
            ColorPicker("Speed Circle Color", selection: $speedCircleColor)
                .onAppear {
                    // Update the hex value when the view appears
                    if let hex = speedCircleColor.toHex() {
                        speedCircleColorHex = hex
                    }
                }
                .onReceive([self.speedCircleColor].publisher.first()) { newColor in
                    // Update whenever the color changes
                    if let hex = newColor.toHex() {
                        speedCircleColorHex = hex
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
            
            
            Spacer()
            
            // Reset Button for Total Distance
            Button(action: {
                // Action to reset the total distance
                speedManager.totalDistance = 0.0
            }) {
                HStack {
                    // Icon for the reset button
                    Image(systemName: "arrow.counterclockwise")  // SF Symbol for reset
                        .font(.title3)  // Icon size
                        .foregroundColor(.white)
                    
                    // Text for the reset button
                    Text("Reset Distance")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.red.opacity(0.8))  // Background color for the button
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()

            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            speedCircleColor = Color.fromHex(speedCircleColorHex)
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}









