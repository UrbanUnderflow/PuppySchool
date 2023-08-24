//
//  ProfileMenuItem.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/21/23.
//

import SwiftUI

class ProfileMenuItemViewModel: ObservableObject {
    @Published var title: String
    @Published var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
struct ProfileMenuItemView: View {
    @ObservedObject var viewModel: ProfileMenuItemViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(.headline)
                .foregroundColor(Color.secondaryWhite)
                .bold()

            Spacer()
            
            Text(viewModel.value)
                .font(.headline)
                .foregroundColor(Color.secondaryWhite)
                .bold()

        }
        .padding(.horizontal, 20)
        Rectangle()
            .fill(Color.secondaryWhite)
            .opacity(0.4)
            .frame(height: 1)
            .padding(.horizontal, 20)
    }
}

struct ProfileMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuItemView(viewModel: ProfileMenuItemViewModel(title: "CURRENT", value: "0"))
    }
}
