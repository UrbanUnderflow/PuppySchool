//
//  PuppyLog.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Foundation

enum PuppyLogType: String {
    case walk
    case poop
    case ate
    case water
    case sleep
    case training
}

struct PuppyLog: Equatable {
    var id: String
    var text: String
    var type: PuppyLogType
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, text: String, type: PuppyLogType, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.text = text
        self.type = type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        
        self.type = PuppyLogType(rawValue: dictionary["type"] as? String ?? "") ?? .walk
        self.text = dictionary["text"] as? String ?? ""
      
        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)

    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "text": text,
            "type": type.rawValue,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}

extension Array where Element == PuppyLog {
    func sortedAndGroupedByDate() -> [(date: Date, logs: [PuppyLog])] {
        let calendar = Calendar.current
        let groupedLogs = Dictionary(grouping: self) { (log) -> Date in
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: log.createdAt)
            return calendar.date(from: dateComponents) ?? log.createdAt
        }
        
        return groupedLogs
            .sorted { $0.key < $1.key }
            .map { (date: $0.key, logs: $0.value.sorted { $0.createdAt < $1.createdAt })}
    }
}
