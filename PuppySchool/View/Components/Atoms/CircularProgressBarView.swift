//
//  CircularProgressBarView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/3/23.
//

import SwiftUI
import Foundation

struct CircularProgressBarView: View {
    var progress: Double
    var maxProgress: Double
    var colors: (start: Color, end: Color)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.darkPurple)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress / self.maxProgress, 1.0)))
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [colors.start, colors.end]), startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct CircularProgressBarDecreaseView: View {
    var progress: Double
    var maxProgress: Double
    let colors: (start: Color, end: Color)

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: CGFloat(min(progress / maxProgress, 1.0)), to: 1.0)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(getColor())
                .rotationEffect(Angle(degrees: -90.0))
                .animation(.linear)
        }
    }
    
    private func getColor() -> Color {
        let remainingPercentage = progress / maxProgress
        
        if remainingPercentage <= 0.1 {
            return .red
        } else if remainingPercentage <= 0.2 {
            return .orange
        } else {
            return colors.start
        }
    }
}
