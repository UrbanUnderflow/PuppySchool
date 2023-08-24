//
//  ToastView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI

class ToastViewModel: ObservableObject {
    @Published var message: String
    @Published var backgroundColor: Color
    @Published var textColor: Color
    @Published var icon: Icon?
    
    init(message: String, backgroundColor: Color, textColor: Color, icon: Icon? = nil) {
        self.message = message
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.icon = icon
    }
}

struct ToastView: View {
    @ObservedObject var viewModel: ToastViewModel

    var body: some View {
        HStack {
            if let icon = viewModel.icon {
                IconImage(icon)
            }
            Text(viewModel.message)
                .padding()
                .background(viewModel.backgroundColor)
                .foregroundColor(viewModel.textColor)
                .cornerRadius(8)
        }
    }
}


struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(viewModel: ToastViewModel(message: "Hello", backgroundColor: .secondaryCharcoal, textColor: .secondaryWhite))
    }
}
