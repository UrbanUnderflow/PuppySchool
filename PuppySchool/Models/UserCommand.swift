//
//  UserCommand.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import Foundation

struct UserCommand {
    var id: String
    var command: Command
    var timesCompleted: Int
    var didMaster: Bool
    var createdAt: Date
    var updatedAt: Date
    

    init(id: String,
         command: Command,
         timesCompleted: Int,
         didMaster: Bool,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.command = command
        self.timesCompleted = timesCompleted
        self.didMaster = didMaster
        self.createdAt = createdAt
        self.updatedAt = updatedAt
       
    }

    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        
        if let commandData = dictionary["command"] as? [String: Any] {
            self.command = Command(id: commandData["id"] as? String ?? "", dictionary: commandData)!
        } else {
            self.command = Fixtures.shared.Sit
        }
        
        self.timesCompleted = dictionary["timesCompleted"] as? Int ?? 0
        
        self.didMaster = dictionary["didMaster"] as? Bool ?? false

        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)

    }
    
    func calculateProgress() -> CGFloat {
        return Double(self.timesCompleted) / Double(self.command.completionMax)
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "command": command.toDictionary(),
            "timesCompleted": timesCompleted,
            "didMaster": didMaster,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}
