//
//  MasteredBadge.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/21/23.
//

import Foundation

struct MasteredBadge: Hashable {
    var id: String
    var icon: DogCommandIcon
    
    init(id: String,
         icon: DogCommandIcon) {
        self.id = id
        self.icon = icon
    }
}
