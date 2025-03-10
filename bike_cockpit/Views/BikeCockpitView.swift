import SwiftUI

struct BikeCockpitView: View {
    @State private var distanceLeft: Double = 120.0
    @State private var lineWidth = CGFloat(15)
    @State private var speedCircleColor: Color = Color.white
    
    @ObservedObject var speedManager = SpeedManager()
    @ObservedObject var dateTimeManager = DateTimeManager()  // Use the DateTime manager

    // Use @AppStorage to retrieve user settings
    @AppStorage("speedUnit") var speedUnit: String = "km/h"
    @AppStorage("distanceUnit") var distanceUnit: String = "km"
    @AppStorage("speedCircleColorHex") var speedCircleColorHex: String = "#FFFFFF"

    let maxSpeed: Double = 50.0  // Maximum speed for the circle

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
            BottomControlsView(distanceUnit: distanceUnit, speedManager: speedManager)
            
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
    
    
}

struct BikeCockpitView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCockpitView()
    }
}
