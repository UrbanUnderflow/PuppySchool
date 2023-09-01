//
//  CheckListData.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 9/1/23.
//

import Foundation

class CheckListData {
    static let shared = CheckListData()
    
    lazy var data: [CheckListItem] = [
        CheckListItem(
            id: "Crate",
            title: "Crate",
            imageUrl: "https://m.media-amazon.com/images/I/51n51fAoyPL._SL250_.jpg",
            productURL: "https://amzn.to/3OLxwsk",
            description: "A crate is a secure space for your puppy, resembling a den environment. It aids in housebreaking and ensures safety when you can't supervise directly.",
            whyItsImportant: [
                "Safety First: Keeps puppy safe from household hazards when unsupervised.",
                "Housebreaking: Puppies usually avoid soiling their sleeping quarters; helps in potty training.",
                "Comfort Zone: Provides a personal space where the puppy can relax and sleep.",
                "Travel: Safest way to transport your puppy in a car.",
                "Avoid Destruction: Prevents puppy from destructive behaviors when alone.",
                "Routine and Discipline: Instills a sense of routine and discipline in your puppy's life.",
            ],
            createdAt: Date(),
            updatedAt: Date()
        ),
        CheckListItem(
            id: "HouseLine",
            title: "Puppy House Line",
            imageUrl: "https://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B06XGZ426H&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=tdg10e-20&language=en_US",
            productURL: "https://amzn.to/3qOGNIe",
            description: "A house line is a lightweight leash that can be left attached to your puppy when they are out of the crate. It aids in preventing unwanted behaviors by allowing you to guide your puppy without physically intervening.",
            whyItsImportant: [
                "Prevent Unwanted Behaviors: Helps to prevent unwanted behaviors like jumping up on furniture or counter surfing.",
                "Positive Reinforcement: Allows you to guide your puppy to the correct behavior and reward them.",
                "Safety: Helps to keep your puppy safe by keeping them close and preventing them from running into dangerous areas.",
                "Training: Aids in training sessions by allowing you to guide your puppy without physically intervening.",
                "Control: Gives you more control over your puppy when they are learning house rules.",
            ],
            createdAt: Date(),
            updatedAt: Date()
        ),

        CheckListItem(
            id: "LongTrainingLeash",
            title: "Long Training Leash",
            imageUrl: "https://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B07WPPG9JL&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=tdg10e-20&language=en_US",
            productURL: "https://amzn.to/3KMnLbW",
            description: "A longer than standard leash, typically ranging from 10 to 30 feet. It's useful for recall training and other distance commands.",
            whyItsImportant: ["Distance Training: Allows for training commands like 'come' while still having a level of control.",
                              "Safety: Ensures the dog doesn't run off in an uncontrolled environment."],
            createdAt: Date(),
            updatedAt: Date()
        ),
        CheckListItem(
            id: "Toys",
            title: "Chew Toys",
            imageUrl: "https://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B09BBM5CX8&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=tdg10e-20&language=en_US",
            productURL: "https://amzn.to/44hk4lM",
            description: "Toys cater to a puppy's instinctual need to chew. They also act as a distraction from potentially destructive chewing habits.",
            whyItsImportant: ["Teething: Helps puppies soothe their gums during the teething phase.",
                              "Mental Stimulation: Keeps puppies mentally engaged and entertained.",
                              "Distraction: Deters them from chewing on furniture or other unwanted items."],
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        CheckListItem(
            id: "TrainingTreats",
            title: "Training Treats",
            imageUrl: "https://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B06XPHY9VQ&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=tdg10e-20&language=en_US",
            productURL: "https://amzn.to/3YKuKIm",
            description: "Small treats specifically used as rewards during training sessions.",
            whyItsImportant: ["Positive Reinforcement: Rewards good behavior, making training sessions more effective.",
                              "Motivation: Encourages your puppy to follow commands and instructions.",
                              "Bonding: Enhances the bond between the owner and the puppy during training."],
            createdAt: Date(),
            updatedAt: Date()
        ),
    ]
    
}
