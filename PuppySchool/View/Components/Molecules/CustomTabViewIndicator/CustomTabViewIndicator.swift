//
//  CustomTabViewIndicator.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/31/23.
//

import SwiftUI

struct CustomTabViewIndicator: View {
    @Binding var selection: Int
    var tabCount: Int
    var dotColor: Color
    
    var dotSize: CGFloat = 10
    var dotSpacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<tabCount, id: \.self) { index in
                Circle()
                    .foregroundColor(index == selection ? dotColor : dotColor.opacity(0.5))
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}

struct CustomTabViewIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabViewIndicator(selection: .constant(1), tabCount: 5, dotColor: .white)
    }
}
