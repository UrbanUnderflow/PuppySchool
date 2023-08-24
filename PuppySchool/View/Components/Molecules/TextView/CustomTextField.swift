//
//  CustomTextField.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/30/23.
//

import SwiftUI

struct CustomTextField: View {
    @State var text: String
    let placeholder: String
    let placeholderColor: Color
    let foregroundColor: Color
    let isSecure: Bool
    @State var showSecureText: Bool
    @State private var isEditing: Bool

    init(text: String, placeholder: String, placeholderColor: Color, foregroundColor: Color, showSecureText: Bool = false, isSecure: Bool = false, isEditing: Bool = false) {
        self.text = text  // Note the underscore, which is required when initializing @Binding properties
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.foregroundColor = foregroundColor
        self.isSecure = isSecure
        self._showSecureText = State(initialValue: showSecureText)
        self._isEditing = State(initialValue: isEditing)
    }
    
    var textField: some View {
        VStack {
            if isSecure {
                Group {
                    if showSecureText == false {
                        TextField("", text: $text, onEditingChanged: { editing in
                            self.isEditing = editing
                        })
                    } else {
                        SecureField("", text: $text, onCommit: {
                            self.isEditing = false
                        })
                    }
                }
            } else {
                TextField("", text: $text, onEditingChanged: { editing in
                    self.isEditing = editing
                })
            }
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty && !isEditing {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
            }

            textField
                .foregroundColor(foregroundColor)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var sampleText: String = ""

    static var previews: some View {
        VStack {
            CustomTextField(text: sampleText, placeholder: "Email", placeholderColor: .gray, foregroundColor: .black, isSecure: false)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding()

            CustomTextField(text: sampleText, placeholder: "Password", placeholderColor: .gray, foregroundColor: .black, showSecureText: false, isSecure: true)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding()
        }
        .background(Color(.systemBackground))
    }
}

