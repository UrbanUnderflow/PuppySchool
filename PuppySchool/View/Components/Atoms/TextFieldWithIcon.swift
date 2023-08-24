//
//  TextFieldWithIcon.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI

struct TextFieldWithIcon: View {
    @Binding var text: String
    let placeholder: String
    let icon: Icon
    let isSecure: Bool
    @State private var showSecureText: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 56)
                .allowsHitTesting(false) // Add this

            HStack {
                Spacer()
                IconImage(icon)
                    .frame(width: 22, height: 22)
                    .padding(.trailing, 5)
                
                CustomTextField(text: text, placeholder: placeholder, placeholderColor: Color.gray, foregroundColor: .secondaryCharcoal, showSecureText: showSecureText, isSecure: isSecure)
                
                if isSecure {
                    Button(action: {
                        showSecureText = false
                    }) {
                        Image(systemName: showSecureText ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
        }
        .cornerRadius(10)
    }
}

struct TextFieldWithIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithIcon(text: .constant(""), placeholder: "Email address", icon: .sfSymbol(.message, color: .secondaryCharcoal), isSecure: false)
    }
}
