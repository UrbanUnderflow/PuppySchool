//
//  UserNotification.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation

struct UserNotification: Identifiable {
    var id: String
    var notification: TimeSensativeNotification
    var wasDelivered: Bool
    var wasRead: Bool
    var createdAt: Date
    var updatedAt: Date

    init(id: String, notification: TimeSensativeNotification, wasDelivered: Bool, wasRead: Bool, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.notification = notification
        self.wasDelivered = wasDelivered
        self.wasRead = wasRead
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init?(id: String, dictionary: [String: Any]) {
        guard let notificationData = dictionary["notification"] as? [String: Any],
              let wasDelivered = dictionary["wasDelivered"] as? Bool,
              let wasRead = dictionary["wasRead"] as? Bool,
              let createdAtTimestamp = dictionary["createdAt"] as? Double,
              let updatedAtTimestamp = dictionary["updatedAt"] as? Double,
              let notification = TimeSensativeNotification(id: notificationData["id"] as? String ?? "", dictionary: notificationData) else {
            return nil
        }

        self.id = id
        self.notification = notification
        self.wasDelivered = wasDelivered
        self.wasRead = wasRead
        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "notification": notification.toDictionary(),
            "wasDelivered": wasDelivered,
            "wasRead": wasRead,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}
