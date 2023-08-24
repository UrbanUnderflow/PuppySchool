//
//  Command.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import Foundation

enum CommandCategory: String {
    case foundational = "Foundational Training"
    case safety = "Safety Commands"
    case obedience = "Obedience Commands"
    case playful = "Playful/Trick Commands"
    case advanced = "Advanced Movement Commands"
    case task = "Problem-Solving/Task-Oriented Commands"
}

enum Difficulty: String {
    case beginner
    case intermediate
    case advanced
}

enum Environment: String {
    case indoor
    case outdoor
    case social
}

enum DogStage: String, CaseIterable {
    case puppy = "imprint"
    case adolescent
    case adult
}

struct Command: Hashable {
    var id: String
    var name: String
    var description: String
    var steps: [String]
    var icon: DogCommandIcon
    var category: CommandCategory
    var difficulty: Difficulty
    var environment: Environment
    var dogStage: DogStage
    var completionMax: Int
    var createdAt: Date
    var updatedAt: Date

    init(id: String,
         name: String,
         description: String,
         steps: [String],
         icon: DogCommandIcon,
         category: CommandCategory,
         difficulty: Difficulty,
         environment: Environment,
         dogStage: DogStage,
         completionMax: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.steps = steps
        self.icon = icon
        self.category = category
        self.difficulty = difficulty
        self.environment = environment
        self.dogStage = dogStage
        self.completionMax = completionMax
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.name = dictionary["name"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.steps = dictionary["steps"] as? [String] ?? []

        self.icon = DogCommandIcon(rawValue: dictionary["icon"] as? String ?? "") ?? .sit
        self.category = CommandCategory(rawValue: dictionary["category"] as? String ?? "") ?? .foundational
        self.difficulty = Difficulty(rawValue: dictionary["difficulty"] as? String ?? "") ?? .beginner
        self.environment = Environment(rawValue: dictionary["environment"] as? String ?? "") ?? .indoor
        self.dogStage = DogStage(rawValue: dictionary["dogStage"] as? String ?? "") ?? .puppy
        self.completionMax = dictionary["completionMax"] as? Int ?? 0
        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
    }
    
    func updateCommandObject() -> Command {
        var newCommand = self
        newCommand.updatedAt = Date()
        // Assuming there's a similar service for commands
        // CommandService.sharedInstance.command = self

        return newCommand
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description,
            "steps": steps,
            "icon": icon.rawValue,
            "category": category.rawValue,
            "difficulty": difficulty.rawValue,
            "environment": environment.rawValue,
            "dogStage": dogStage.rawValue,
            "completionMax": completionMax,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}
