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
    let isDisabled: Bool
    @State private var showSecureText: Bool = false
    
    init(text: Binding<String>, placeholder: String, icon: Icon, isSecure: Bool, isDisabled: Bool = false, showSecureText: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        self.isDisabled = isDisabled
        self.showSecureText = showSecureText
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.darkPurple)
                .frame(height: 56)
            
            HStack {
                Spacer()
                IconImage(icon)
                    .frame(width: 22, height: 22)
                    .padding(.trailing, 5)
                
                CustomTextField(text: $text, placeholder: placeholder, placeholderColor: Color.gray, foregroundColor: .secondaryWhite, isSecure: isSecure, showSecureText: showSecureText)
                
                if isSecure {
                    Button(action: {
                        showSecureText.toggle()
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
        TextFieldWithIcon(text: .constant(""), placeholder: "Email address", icon: .sfSymbol(.message, color: .black), isSecure: false)
    }
}
