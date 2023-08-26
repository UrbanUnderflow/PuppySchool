//
//  ProgressViewStyle+PuppySchool.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/25/23.
//

import Foundation
import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.darkPurple)
                    .frame(width: geometry.size.width, height: 5)
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 5)
            }
        }
    }
}
