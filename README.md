# Bike Cockpit App

## Overview

**Bike Cockpit** is an iOS application designed to help cyclists monitor and track their riding performance in real-time. The app displays key metrics such as speed, distance traveled, and allows the user to customize various settings like units of measurement and display preferences. Its minimalist design focuses on delivering critical information in a simple, intuitive interface.

## Features

- **Real-Time Speed Tracking:** Displays your current speed with a customizable circular gauge.
- **Distance Tracking:** Keeps track of the total distance you've traveled during your ride.
- **Unit Selection:** Choose between kilometers/miles for both speed and distance units.
- **Customizable Interface:** Personalize the speedometer color through a settings menu.
- **Date and Time Display:** The app shows the current date and time at the top of the cockpit screen.
- **Reset Functionality:** Reset the total distance traveled with a simple button press in the settings.
- **Smooth Navigation Transitions:** The app features smooth animations when navigating between the cockpit and settings screens.

## Screenshots

> Include relevant screenshots here.

## Getting Started

### Prerequisites

- iOS 14.0 or later
- Xcode 12.0 or later
- Swift 5

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/bike-cockpit-app.git
   ```
2. **Open the project**:
   Open the `.xcodeproj` file in Xcode.
   
3. **Build the app**:
   Select a target device (e.g., iPhone 14) and press `Cmd + R` to build and run the app.

## Usage

1. **Main Cockpit Screen**: Upon launching the app, you will see the main cockpit screen showing:
   - Current speed in the selected unit (km/h or mph)
   - Total distance traveled (in km or miles)
   - Date and time

2. **Changing Settings**: 
   - Tap the gear icon at the top right to enter the settings screen.
   - From the settings screen, you can:
     - Change the speed and distance units.
     - Customize the color of the speedometer's progress circle.
     - Reset the total distance traveled to zero.

3. **Returning to Cockpit**: Tap the back button in the settings screen to return to the main cockpit.

## Code Structure

The code is organized into the following main components:

- **`BikeCockpitView.swift`**: The main view of the app that displays the speed, distance, and date/time.
- **`SettingsView.swift`**: The settings screen where users can customize the app's appearance and behavior.
- **`SpeedManager.swift`**: Handles all location services and speed/distance calculations.
- **`DateTimeManager.swift`**: Handles real-time date and time updates.

### Key Classes and Methods

- `SpeedManager`: Uses CoreLocation to track speed and calculate total distance traveled.
- `SettingsView`: A settings screen that lets users adjust preferences such as speed units and the appearance of the speed circle.
- `Color.fromHex()`: Helper function to convert a hexadecimal string to a SwiftUI `Color`.

## Customization

### Change the Appearance of the Speedometer

You can modify the default colors and circle design by adjusting the following properties in the settings screen:
- Speed circle color (via `ColorPicker`)
  
The speedometer updates automatically in real-time based on user preferences.

## To Do

- [ ] Add support for altitude tracking.
- [ ] Integrate route mapping with a map view.
- [ ] Add a history log of past rides.
- [ ] Implement haptic feedback for speed notifications.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch-name`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch-name`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
