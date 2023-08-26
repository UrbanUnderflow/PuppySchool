//
//  CustomTextField.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/30/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color
    var foregroundColor: Color
    var isSecure: Bool
    var isDisabled: Bool
    var showSecureText: Bool
    @State private var isEditing: Bool = false

    // Note that the Binding parameters should be passed in from the parent view
    init(text: Binding<String>, placeholder: String, placeholderColor: Color, foregroundColor: Color, isSecure: Bool = false, isDisabled: Bool = false, showSecureText: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.foregroundColor = foregroundColor
        self.isSecure = isSecure
        self.isDisabled = isDisabled
        self.showSecureText = showSecureText
    }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty && !isEditing {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
            }
            Group {
                if isSecure {
                    if showSecureText {
                        TextField("", text: $text)
                            .disabled(isDisabled)
                    } else {
                        SecureField("", text: $text, onCommit: {
                            self.isEditing = false
                        })
                    }
                } else {
                    TextField("", text: $text)
                        .disabled(isDisabled)
                }
            }
            .foregroundColor(foregroundColor)
            .onTapGesture {
                self.isEditing = true
            }
            .onChange(of: text) { newValue in
                if newValue.isEmpty {
                    isEditing = false
                }
            }
        }
    }
}
