//
//  Color+QuickLifts.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryPurple = Color("primaryPurple")
    static let darkPurple = Color("darkPurple")
    static let primaryBlue = Color("primaryBlue")
    static let secondaryCharcoal = Color("secondaryCharcoal")
    static let blueGray = Color("blueGray")
    static let lightGray = Color("lightGray")
    static let secondaryWhite = Color("secondaryWhite")
    static let wind = Color("wind")
    static let ash = Color("ash")
    static let secondaryPink = Color("secondaryPink")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension LinearGradient {
    static var primaryGradient: LinearGradient {
        return LinearGradient(
            gradient: Gradient(stops: [
                Gradient.Stop(color: Color(red: 0.85, green: 0.34, blue: 1), location: 0.00),
                Gradient.Stop(color: Color(red: 0.24, green: 0.58, blue: 1), location: 1.00),
            ]),
            startPoint: UnitPoint(x: 0.93, y: 0.78),
            endPoint: UnitPoint(x: 0.09, y: 0.24)
        )
    }
}
