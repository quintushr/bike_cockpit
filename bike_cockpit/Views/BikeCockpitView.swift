import SwiftUI

struct BikeCockpitView: View {
    @State private var distanceLeft: Double = 120.0
    let maxSpeed: Double = 50.0  // Maximum speed for the circle
    @State private var lineWidth = CGFloat(15)
    @ObservedObject var speedManager = SpeedManager()
    @ObservedObject var dateTimeManager = DateTimeManager()  // Use the DateTime manager

    // Use @AppStorage to retrieve user settings
    @AppStorage("speedUnit") var speedUnit: String = "km/h"
    @AppStorage("distanceUnit") var distanceUnit: String = "km"
    @AppStorage("speedCircleColorHex") var speedCircleColorHex: String = "#FFFFFF"

    @State private var speedCircleColor: Color = Color.white


    var body: some View {
        NavigationView {
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
            SpeedCircleView(speed: convertedSpeed, maxSpeed: maxSpeed, lineWidth: lineWidth, foregroundColor: speedCircleColor, speedUnit: speedUnit)

            Spacer()

            Spacer()

            // Distance traveled and settings button
            BottomControlsView(distance: convertedDistance, distanceUnit: distanceUnit)

            Spacer()
        }.background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                // Convert hex to Color when the view appears
                speedCircleColor = Color.fromHex(speedCircleColorHex)
            }
        }
    }
    
    // Computed property to convert speed based on selected unit
    var convertedSpeed: Double {
        if speedUnit == "mph" {
            return speedManager.speed * 0.621371  // Convert km/h to mph
        } else {
            return speedManager.speed  // Default to km/h
        }
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

struct BikeCockpitView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCockpitView()
    }
}
