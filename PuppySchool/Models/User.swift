//
//  User.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation

struct User {
    var id: String
    var email: String
    var dogName: String
    var dogStage: DogStage
    var profileImageURL: String
    var createdAt: Date
    var updatedAt: Date

    init(id: String,
         email: String,
         dogName: String,
         dogStage: DogStage,
         profileImageURL: String?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.dogName = dogName
        self.dogStage = dogStage
        self.email = email
        self.profileImageURL = profileImageURL ?? ""
        self.createdAt = createdAt
        self.updatedAt = updatedAt
       
    }

    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.email = dictionary["email"] as? String ?? ""
        self.dogName = dictionary["dogName"] as? String ?? ""
        self.dogStage = DogStage(rawValue: dictionary["dogStage"] as? String ?? "imprint") ?? .puppy
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""

        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)

    }
    
    func updateUserObject() -> User {
        var newUser = self
        newUser.updatedAt = Date()
        UserService.sharedInstance.user = self

        return newUser
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "email": email,
            "dogName": dogName,
            "dogStage": dogStage.rawValue,
            "profileImageURL": profileImageURL,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}

