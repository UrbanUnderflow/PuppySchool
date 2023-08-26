//
//  BackButton.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/17/23.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        IconImage(.sfSymbol(.chevLeft, color: .secondaryWhite))
                .frame(width: 24, height: 24)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
