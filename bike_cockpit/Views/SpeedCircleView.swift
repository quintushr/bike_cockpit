//
//  SpeedCircleView.swift
//  bike_cockpit
//
//  Created by quintus on 15/09/2024.
//

import SwiftUI

struct SpeedCircleView: View {
    let speed: Double
    let maxSpeed: Double
    let lineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.2)
                .foregroundColor(.white)
            
            // Progress circle showing the speed
            Circle()
                .trim(from: 0.0, to: CGFloat(speed / maxSpeed))  // Adapt the arc to show speed progress
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear, value: speed)
            
            // Display speed at the center
            VStack {
                Text("\(Int(speed))")
                    .font(.system(size: 75, weight: .bold))
                    .foregroundColor(.white)
                
                Text("km/h")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 310, height: 390)
    }
}
