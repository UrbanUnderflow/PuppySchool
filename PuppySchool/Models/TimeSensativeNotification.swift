//
//  TimeSensativeNotification.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation

enum NotificationCategory: String, Codable {
    case health
    case exercise
    case training
    case socialization
    case grooming
}

struct TimeSensativeNotification: Hashable, Identifiable {
    var id: String
    var title: String
    var category: NotificationCategory
    var message: String
    var deliverAtXWeeks: Int
    var isRecurring: Bool
    var recurrenceInterval: Int? // in weeks
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, title: String, category: NotificationCategory, message: String, deliverAtXWeeks: Int, isRecurring: Bool, recurrenceInterval: Int? = nil, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.title = title
        self.category = category
        self.message = message
        self.deliverAtXWeeks = deliverAtXWeeks
        self.isRecurring = isRecurring
        self.recurrenceInterval = recurrenceInterval
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init?(id: String, dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String,
              let categoryString = dictionary["category"] as? String,
              let category = NotificationCategory(rawValue: categoryString),
              let message = dictionary["message"] as? String,
              let deliverAtXWeeks = dictionary["deliverAtXWeeks"] as? Int,
              let isRecurring = dictionary["isRecurring"] as? Bool,
              let createdAtTimestamp = dictionary["createdAt"] as? Double,
              let updatedAtTimestamp = dictionary["updatedAt"] as? Double else {
            return nil
        }

        self.id = id
        self.title = title
        self.category = category
        self.message = message
        self.deliverAtXWeeks = deliverAtXWeeks
        self.isRecurring = isRecurring
        self.recurrenceInterval = dictionary["recurrenceInterval"] as? Int
        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
    }

    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "title": title,
            "category": category.rawValue,
            "message": message,
            "deliverAtXWeeks": deliverAtXWeeks,
            "isRecurring": isRecurring,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]

        if let recurrenceInterval = recurrenceInterval {
            dictionary["recurrenceInterval"] = recurrenceInterval
        }

        return dictionary
    }
}
