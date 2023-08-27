//
//  NotificationService.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation
import UserNotifications
import Firebase

class NotificationService {
    static let sharedInstance = NotificationService()
    private var db: Firestore!

    let timeSensitiveNotifications = TimeSensativeNotificationData.shared.data
    var notifications = [TimeSensativeNotification]()
    var userNotifications = [UserNotification]()

    private init() {
        db = Firestore.firestore()
    }
    
    func saveTimeSensitiveNotifications(completion: @escaping (Error?) -> Void) {
        let notificationsRef = db.collection("notifications")
                
        for notification in self.timeSensitiveNotifications {
            let documentID = notification.title.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "/", with: "") // remove spaces and slashes from title
            let newNotificationRef = notificationsRef.document(documentID)
            var notificationData = notification.toDictionary()
            
            newNotificationRef.setData(notificationData) { error in
                if let error = error {
                    print("Error writing notification to Firestore: \(error)")
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchTimeSensitiveNotifications() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userId).collection("notifications").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting notifications: \(err)")
            } else {
                self.notifications = querySnapshot?.documents.compactMap { document in
                    return TimeSensativeNotification(id: document.documentID, dictionary: document.data())
                } ?? []
            }
        }
    }
    
    func checkForNotificationsToSend(puppyBirthday: Date, notifications: [TimeSensativeNotification]) {
        let calendar = Calendar.current
        let currentDate = Date()
        let puppyAgeInWeeks = calendar.dateComponents([.weekOfYear], from: puppyBirthday, to: currentDate).weekOfYear ?? 0
        
        // Filter notifications that should be sent based on the puppy's age
        let notificationsToSendBasedOnWeeks = notifications.filter { notification in
            return puppyAgeInWeeks >= notification.deliverAtXWeeks
        }
        
        func shouldAppendNotification(_ notification: TimeSensativeNotification, userNotifications: [UserNotification]) -> Bool {
            
            // Check if the notification already exists in userNotifications
            var exists = userNotifications.filter { $0.notification.id == notification.id }
            print(exists.count)
            if let existingNotification = userNotifications.first(where: { $0.notification.id == notification.id }) {
                // If the notification is recurring, check if the recurrenceInterval has passed
                if existingNotification.notification.isRecurring {
                    // Get the time interval in seconds between the existing notification's updatedAt date and now
                    let timeIntervalSinceLastUpdate = Date().timeIntervalSince(existingNotification.updatedAt)
                    // Convert the recurrenceInterval from weeks to seconds
                    if let recurrenceInterval = existingNotification.notification.recurrenceInterval {
                        let recurrenceIntervalInSeconds = TimeInterval(recurrenceInterval * 7 * 24 * 60 * 60)
                        // If the recurrenceInterval has passed, we should append the notification
                        if timeIntervalSinceLastUpdate >= recurrenceIntervalInSeconds {
                            return true
                        }
                    }
                    // If the recurrenceInterval has not passed, or if there is no recurrenceInterval, we should not append the notification
                    return false
                }

                // If the notification is not recurring and it already exists, we should not append it
                return false
            }
            // If the notification does not already exist in userNotifications, we should append it
            return true
        }
        
        var newUserNotificationsToSend: [UserNotification] = []
        for notification in notificationsToSendBasedOnWeeks {
            if shouldAppendNotification(notification, userNotifications: self.userNotifications) {
                newUserNotificationsToSend.append(UserNotification(id: UUID().uuidString, notification: notification, wasDelivered: false, wasRead: false, createdAt: Date(), updatedAt: Date()))
            }
        }

        if !newUserNotificationsToSend.isEmpty {
            saveUserNotifications(userNotifications: newUserNotificationsToSend) { error in
                print(error)
            }
        }
    }
    
    func saveUserNotifications(userNotifications: [UserNotification], completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "No user ID found", code: 401, userInfo: nil))
            return
        }
        
        let userNotificationRef = db.collection("users").document(userId).collection("userNotifications")
        let batch = db.batch() // Using batch to save multiple commands at once
        
        for notification in userNotifications {
            let newNotificationRef = userNotificationRef.document(notification.id) // Generate a new document for each command
          //  self.userNotifications.append(notification)
            batch.setData(notification.toDictionary(), forDocument: newNotificationRef)
        }
        
        batch.commit { err in
            completion(err)
        }
    }
    
    func fetchUserNotifications(completion: @escaping ([UserNotification]?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "No user ID found", code: 401, userInfo: nil))
            return
        }
        
        db.collection("users").document(userId).collection("userNotifications").getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(nil, err)
            } else {
                let userNotifications = querySnapshot?.documents.compactMap { document in
                    return UserNotification(id: document.documentID, dictionary: document.data())
                } ?? []
                self.userNotifications = userNotifications
                completion(userNotifications, nil)
            }
        }
    }


    
    
//    func scheduleDailyNotification() {
//        // Create notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Training"
//        content.body = "You havent trained hendrix today. don't forget to train for at least 15 mins today."
//        content.sound = UNNotificationSound.default
//
//        // Calculate the trigger time (2 hours before the task expires)
//        let calendar = Calendar.current
//        guard let expirationDate = getActivityExpirationFromUserDefaults() else {
//            print("Error: Couldn't get activity expiration date from UserDefaults")
//            return
//        }
//        let triggerDate = calendar.date(byAdding: .hour, value: -2, to: expirationDate)!
//        let triggerComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
//
//        // Create a trigger
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
//
//        // Create a notification request
//        let request = UNNotificationRequest(identifier: "dailyActivityReminder", content: content, trigger: trigger)
//
//        // Schedule the notification
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling daily notification: \(error.localizedDescription)")
//            } else {
//                print("Daily notification scheduled successfully")
//            }
//        }
//    }
    
    func scheduleTimeSensativeMessage() {
        // scheduel time senstavie notifications array
        // We should do this by saving a ReviecedMessage Model to file base that maps back to one of our notification in the notifications array.
    }
}
