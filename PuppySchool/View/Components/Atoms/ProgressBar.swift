//
//  ProgressBar.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/11/23.
//

import SwiftUI

struct ProgressBar: View {
    @State var progress: CGFloat
    let color: Color
    let backgroundColor: Color?
    
    @State private var animatedProgress: CGFloat = 0
    
    init(progress: CGFloat, color: Color, backgroundColor: Color? = Color.gray) {
        self._progress = State(initialValue: progress)
        self.color = color
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(backgroundColor != nil ? backgroundColor! : Color.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)
                    .frame(width: animatedProgress * geometry.size.width) // Use animatedProgress for the width
            }
        }
        .cornerRadius(10)
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                animatedProgress = progress
            }
        }
    }
}
