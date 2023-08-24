//
//  CloseButtonView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/16/23.
//

import Foundation
import SwiftUI

struct CloseButtonView: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                IconImage(.sfSymbol(.close, color: .secondaryWhite))
                    .frame(width: 36, height: 36)
                    .onTapGesture(perform: action)
            }
        }
    }
}
