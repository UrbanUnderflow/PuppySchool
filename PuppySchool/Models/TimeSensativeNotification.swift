//
//  TimeSensativeNotification.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation

struct TimeSensativeNotification: Hashable, Identifiable {
    var id: String
    var title: String
    var category: String
    var message: String
    var deliverAtXWeeks: Int
    var hasBeenDelivered: Bool
    var isRecurring: Bool
    var recurrenceInterval: Int? // in weeks
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, title: String, category: String, message: String, deliverAtXWeeks: Int, hasBeenDelivered: Bool, isRecurring: Bool, recurrenceInterval: Int? = nil, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.title = title
        self.category = category
        self.message = message
        self.deliverAtXWeeks = deliverAtXWeeks
        self.hasBeenDelivered = hasBeenDelivered
        self.isRecurring = isRecurring
        self.recurrenceInterval = recurrenceInterval
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
//    init?(id: String, dictionary: [String: Any]) {
//        self.id = id
//
//        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
//        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0
//
//        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
//        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
//
//    }
    
//    init(id: String, createdAt: Date, updatedAt: Date) {
//        self.id = id
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//    }
    
//    func toDictionary() -> [String: Any] {
//        return [
//            "id": id,
//            "createdAt": createdAt.timeIntervalSince1970,
//            "updatedAt": updatedAt.timeIntervalSince1970
//        ]
//    }
}
