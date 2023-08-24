//
//  DogStageDescriptions.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/22/23.
//

import Foundation

struct DogStageDescription: Identifiable {
    var id: UUID
    var title: String
    var stage: DogStage
    var icon: DogStageIcon
    var description: String
    var longDescription: String
    var tips: [DogStageTips]
    var ageRange: String
    
    init(id: UUID, title: String, stage: DogStage, icon: DogStageIcon, description: String, longDescription: String, tips: [DogStageTips], ageRange: String) {
        self.id = id
        self.title = title
        self.stage = stage
        self.icon = icon
        self.tips = tips
        self.description = description
        self.longDescription = longDescription
        self.ageRange = ageRange
    }
    
}
