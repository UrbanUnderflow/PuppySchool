//
//  NotificationCardView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/27/23.
//

import SwiftUI

class NotificationCardViewModel: ObservableObject {
    @Published var timeSensativeNotification: TimeSensativeNotification
    
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var icon: MessageImage? = nil
    @Published var weeksLabel: String = ""
    
    init(notification: TimeSensativeNotification) {
        self.timeSensativeNotification = notification
        self.title = notification.title
        self.message = notification.message
        self.icon = notification.icon
        self.weeksLabel = "\(notification.deliverAtXWeeks) weeks"
    }
    
}

struct NotificationCardView: View {
    @ObservedObject var viewModel: NotificationCardViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(viewModel.title)
                        .font(.headline)
                        .foregroundColor(.secondaryWhite)
                    Spacer()
                }
                
                HStack {
                    VStack {
                        IconImage(.messageImage(viewModel.icon ?? .care))
                            .frame(width: 140, height: 140)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text(viewModel.message)
                            .foregroundColor(.secondaryWhite)
                            .font(.subheadline)
                    }
                    .padding(.leading)
                }
                .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Text(viewModel.weeksLabel)
                        .foregroundColor(.teal)
                        .font(.subheadline)
                        .bold()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(CardBackground(color: .primaryPurple, border: 0))
            .padding(.horizontal, 20)
        }
    }
}

struct NotificationCardView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCardView(viewModel: NotificationCardViewModel(notification: Fixtures.shared.TimeSensativeNotification))
    }
}
