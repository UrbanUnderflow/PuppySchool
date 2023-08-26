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
    var birthdate: Date
    var dogName: String
    var dogStage: DogStage
    var profileImageURL: String
    var subscriptionType: SubscriptionType
    var createdAt: Date
    var updatedAt: Date

    init(id: String,
         email: String,
         birthdate: Date,
         dogName: String,
         dogStage: DogStage,
         profileImageURL: String?,
         subscriptionType: SubscriptionType,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.dogName = dogName
        self.dogStage = dogStage
        self.email = email
        self.birthdate = birthdate
        self.profileImageURL = profileImageURL ?? ""
        self.subscriptionType = subscriptionType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
       
    }

    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.email = dictionary["email"] as? String ?? ""
        let birthdateStamp = dictionary["createdAt"] as? Double ?? 0
        
        self.birthdate = Date(timeIntervalSince1970: birthdateStamp)

        
        self.dogName = dictionary["dogName"] as? String ?? ""
        self.dogStage = DogStage(rawValue: dictionary["dogStage"] as? String ?? "imprint") ?? .puppy
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        
        self.subscriptionType = SubscriptionType(rawValue: dictionary["subscriptionType"] as? String ?? "") ?? .free

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
            "birthdate": birthdate.timeIntervalSince1970,
            "dogName": dogName,
            "dogStage": dogStage.rawValue,
            "profileImageURL": profileImageURL,
            "subscriptionType": subscriptionType,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ]
    }
}

