//
//  FilteredLogItem.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/23/23.
//

import SwiftUI

class FilteredLogItemViewModel: ObservableObject {
    @Published var icon: Icon
    @Published var text: String
    @Published var time: String
    
    init(icon: Icon, text: String, time: String) {
        self.icon = icon
        self.text = text
        self.time = time
    }
}

struct FilteredLogItem: View {
    @ObservedObject var viewModel: FilteredLogItemViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(randomShadeColor())
                        .frame(width: 50, height: 50)
                    IconImage(viewModel.icon)
                        .frame(width: 32, height: 32)
                }
                .padding(.leading, 20)
                .cornerRadius(20, corners: .all)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        IconImage(.custom(.oval))
                            .frame(width: 10, height: 10)
                        Text(viewModel.time)
                            .font(.footnote)
                            .foregroundColor(Color.secondaryWhite)
                            .bold()
                    }
                    Text(viewModel.text)
                        .font(.subheadline)
                        .foregroundColor(.secondaryWhite)
                        .bold()
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.bottom, 20)
            
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .frame(height: 1)
                .padding(.horizontal, 20)
        }
        
    }
}

struct FilteredLogItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryPurple
            FilteredLogItem(viewModel: FilteredLogItemViewModel(icon: .commands(.paw), text: "Hendrix took a poop", time: "12:00pm"))
        }
    }
}
