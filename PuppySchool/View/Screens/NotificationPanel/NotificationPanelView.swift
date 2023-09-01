//
//  NotificationPanel.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import SwiftUI

class NotificationPanelViewModel: ObservableObject {
	let appCoordinator: AppCoordinator
    let notifications: [UserNotification]

    init(appCoordinator: AppCoordinator, notifications: [UserNotification]) {
		self.appCoordinator = appCoordinator
        self.notifications = notifications
	}

}

struct NotificationPanelView: View {
	@ObservedObject var viewModel: NotificationPanelViewModel
    
    var body: some View {
      VStack {
          HeaderView(viewModel: HeaderViewModel(headerTitle: "Alerts", theme: .dark, type: .close, closeModal: {
              viewModel.appCoordinator.closeModals()
              
          }, actionCallBack: {
              //
          }))
          Divider(color: .white.opacity(0.2), height: 2)
              .padding(.bottom, 20)
          ScrollView {
              VStack(spacing: 12) {
                  ForEach(viewModel.notifications.sorted(by: { $0.notification.deliverAtXWeeks < $1.notification.deliverAtXWeeks }), id: \.self) { notification in
                      NotificationCardView(viewModel: NotificationCardViewModel(notification: notification.notification))
                  }
              }
          }

         Spacer()
          
      }
      .background(Color.darkPurple)
      .onAppear {
          for notification in viewModel.notifications {
              if notification.wasDelivered == false {
                  var newNotification = notification
                  newNotification.wasDelivered = true
                  NotificationService.sharedInstance.updateUserNotification(userNotification: newNotification) { error in
                      if (error == nil) {
                          print("User notification updated to delivered")
                      }
                  }
              }
          }
      }
    }
}

struct NotificationPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPanelView(viewModel: NotificationPanelViewModel(
            appCoordinator: AppCoordinator(serviceManager: ServiceManager()),
            notifications: TimeSensativeNotificationData.shared.data.map { UserNotification(id: UUID().uuidString, notification: $0, wasDelivered: false, wasRead: false, createdAt: Date(), updatedAt: Date())
                
            }))
    }
}
