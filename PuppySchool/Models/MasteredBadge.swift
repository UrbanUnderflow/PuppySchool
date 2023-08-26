//
//  MasteredBadge.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/21/23.
//

import Foundation

struct MasteredBadge: Hashable {
    var id: String
    var icon: DogCommandImages
    
    init(id: String,
         icon: DogCommandImages) {
        self.id = id
        self.icon = icon
    }
}
