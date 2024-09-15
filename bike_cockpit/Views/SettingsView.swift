//
//  SettingsView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct SettingsView: View {
    // Use @AppStorage to store the selected preferences
    @AppStorage("speedUnit") var speedUnit: String = "km/h"  // Default to km/h
    @AppStorage("distanceUnit") var distanceUnit: String = "km"  // Default to kilometers
    @AppStorage("speedCircleColorHex") var speedCircleColorHex: String = "#FFFFFF"  // Default to white (hex format)

    let speedUnits = ["km/h", "mph"]  // Available speed units
    let distanceUnits = ["km", "mi"]  // Available distance units
    
    @State private var speedCircleColor: Color = Color.white  // For the color picker

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(.white)  // Set text color to white for better contrast
                .padding()

            // Speed unit selection
            Picker("Speed Unit", selection: $speedUnit) {
                ForEach(speedUnits, id: \.self) { unit in
                    Text(unit).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))  // Lighten the background of the picker
            .cornerRadius(10)
            .foregroundColor(.white)  // Ensure picker text is white
            
            // Distance unit selection
            Picker("Distance Unit", selection: $distanceUnit) {
                ForEach(distanceUnits, id: \.self) { unit in
                    Text(unit).tag(unit)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))  // Lighten the background of the picker
            .cornerRadius(10)
            .foregroundColor(.white)  // Ensure picker text is white

            // Color picker for speed circle
            ColorPicker("Speed Circle Color", selection: $speedCircleColor)
                .onChange(of: speedCircleColor, perform: { newColor in
                    if let hex = newColor.toHex() {
                        speedCircleColorHex = hex  // Save the new color as hex
                    }
                })
                .padding()
                .background(Color.gray.opacity(0.2))  // Lighten the background of the color picker
                .cornerRadius(10)
                .foregroundColor(.white)  // Ensure picker text is white

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))  // Black background for the page
        .onAppear {
            speedCircleColor = Color.fromHex(speedCircleColorHex)  // Load the saved color
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}





