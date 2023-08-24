//
//  DogStageTips.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/23/23.
//

import Foundation

struct DogStageTips: Hashable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    
    init(id: UUID, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
}
