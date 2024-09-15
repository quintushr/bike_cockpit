//
//  DateTimeManager.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import Foundation
import SwiftUI

class DateTimeManager: ObservableObject {
    @Published var currentDate = Date()
    
    init() {
        // Start a timer to refresh the date and time every second
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.currentDate = Date()  // Update the current date
        }
    }
    
    // Formatter for the date and time
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full   // Full date display (e.g., Monday, September 15, 2024)
        formatter.timeStyle = .short  // Short time display (e.g., 14:45)
        return formatter
    }
}
