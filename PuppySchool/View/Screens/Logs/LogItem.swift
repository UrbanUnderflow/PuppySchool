//
//  LogItem.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import SwiftUI

class LogItemViewModel: ObservableObject {
    @Published var icon: Icon
    @Published var text: String
    @Published var time: String
    
    init(icon: Icon, text: String, time: String) {
        self.icon = icon
        self.text = text
        self.time = time
    }
}

struct LogItem: View {
    @ObservedObject var viewModel: LogItemViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .frame(height: 1)
                .padding(.horizontal, 20)
            
            HStack {
                DottedLineView(color: Color.gray, dashes: 10)
                    .opacity(0.5)
                    .frame(width: 1, height: 80)
                    .padding(.leading, 20)
                
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
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .frame(height: 1)
                .padding(.horizontal, 20)
        }
        
    }
}

struct LogItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryPurple
            LogItem(viewModel: LogItemViewModel(icon: .commands(.paw), text: "Hendrix took a poop", time: "12:00pm"))
        }
    }
}
