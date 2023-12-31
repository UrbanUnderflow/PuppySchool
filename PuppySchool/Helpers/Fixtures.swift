//
//  Fixtures.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import Foundation
import RevenueCat

class Fixtures {
    // Singleton instance
    static let shared = Fixtures()
    
    // Lazy initialization of mock data
    lazy var UserCommand: UserCommand = {
        return PuppySchool.UserCommand(id: "", command: Command(
            id: "Sit",
            name: "Sit",
            description: "Sit down",
            steps: [
                "Hold a treat close to your dog's nose.",
                "Move your hand up, allowing their head to follow the treat and causing their bottom to lower.",
                "Once they’re in a sitting position, say 'Sit,' give them the treat, and share affection."
            ],
            icon: .sit,
            category: .obedience,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ), timesCompleted: 10, didMaster: false, createdAt: Date(), updatedAt: Date())
    }()
    
    lazy var TimeSensativeNotification: TimeSensativeNotification = {
        return TimeSensativeNotificationData.shared.data.first!
    }()
    
    lazy var UserNotification: UserNotification = {
        return PuppySchool.UserNotification(id: UUID().uuidString, notification: Fixtures.shared.TimeSensativeNotification, wasDelivered: false, wasRead: false, createdAt: Date(), updatedAt: Date())
    }()
    
        //Purchase Package
    lazy var yearlyPackage: Package = {
        // StoreProduct properties
        let productType: StoreProduct.ProductType = .consumable
        let productCategory: StoreProduct.ProductCategory = .subscription
        let localizedDescription: String = "A yearly subscription package"
        let localizedTitle: String = "Yearly Subscription"
        let currencyCode: String? = "USD"
        let price: Decimal = 49.99
        let localizedPriceString: String = "$49.99"
        let productIdentifier: String = "com.example.app.yearlysubscription"

        // Create a StoreProduct instance
        let storeProduct = StoreProduct(sk1Product: SK1Product())
        

        // Return a Package instance
        return Package(identifier: "yearlyPackageIdentifier", packageType: .annual, storeProduct: storeProduct, offeringIdentifier: "yearlyOffering")
    }()
    
    // Mock data for Logs
    lazy var puppyLogAte: PuppyLog = {
        return PuppyLog(id: UUID().uuidString, text: "Hendrix has ate", type: PuppyLogType.ate, createdAt:  Date.random(between: 2020, and: 2023) ?? Date(), updatedAt: Date.random(between: 2020, and: 2023) ?? Date())
    }()
    
    lazy var puppyLogWalk: PuppyLog = {
        return PuppyLog(id: UUID().uuidString, text: "Hendrix took a walk", type: PuppyLogType.walk, createdAt:  Date.random(between: 2020, and: 2023) ?? Date(), updatedAt: Date.random(between: 2020, and: 2023) ?? Date())
    }()
    
    lazy var puppyLogTraining: PuppyLog = {
        return PuppyLog(id: UUID().uuidString, text: "Hendrix did some training", type: PuppyLogType.training, createdAt:  Date.random(between: 2020, and: 2023) ?? Date(), updatedAt: Date.random(between: 2020, and: 2023) ?? Date())
    }()
    
    lazy var puppyLogPoop: PuppyLog = {
        return PuppyLog(id: UUID().uuidString, text: "Hendrix used the potty", type: PuppyLogType.ate, createdAt:  Date.random(between: 2020, and: 2023) ?? Date(), updatedAt: Date.random(between: 2020, and: 2023) ?? Date())
    }()
    
    lazy var puppyLogSleep: PuppyLog = {
        return PuppyLog(id: UUID().uuidString, text: "Hendrix went to sleep", type: PuppyLogType.ate, createdAt:  Date.random(between: 2020, and: 2023) ?? Date(), updatedAt: Date.random(between: 2020, and: 2023) ?? Date())
    }()
    
    lazy var Sit: Command = {
        return Command(
            id: "Sit",
            name: "Sit",
            description: "Command your dog to sit in a seated position.",
            steps: [
                "Hold a treat close to your dog's nose.",
                "Move your hand up, allowing their head to follow the treat and causing their bottom to lower.",
                "Once they’re in a sitting position, say 'Sit,' give them the treat, and share affection."
            ],
            icon: .sit,
            category: .obedience,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        )
    }()
}
