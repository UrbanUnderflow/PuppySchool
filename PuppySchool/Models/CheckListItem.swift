//
//  CheckListItem.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Foundation

struct CheckListItem {
    var id: String
    var title: String
    var imageUrl: String
    var productURL: String
    var description: String
    var whyItsImportant: String
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, title: String, imageUrl: String, productURL: String, description: String, whyItsImportant: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.productURL = productURL
        self.description = description
        self.whyItsImportant = whyItsImportant
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.title = dictionary["title"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.productURL = dictionary["productURL"] as? String ?? ""
        
        self.description = dictionary["description"] as? String ?? ""
        self.whyItsImportant = dictionary["whyItsImportant"] as? String ?? ""
        
        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "imageUrl": imageUrl,
            "productURL": productURL,
            "description": description,
            "whyItsImportant": whyItsImportant,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}
