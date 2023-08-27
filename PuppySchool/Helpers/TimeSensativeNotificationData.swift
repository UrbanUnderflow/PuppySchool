//
//  TimeSensativeNotificationData.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation

class TimeSensativeNotificationData {
    // Singleton instance
    static let shared = TimeSensativeNotificationData()
    
    // Lazy initialization of mock data
    lazy var data: [TimeSensativeNotification] = [
           TimeSensativeNotification(id: "1",
             title: "Puppy Socialization",
             category: .socialization,
             message: "It's time to bring your puppy around some other dogs",
             deliverAtXWeeks: 12,
             isRecurring: false,
             createdAt: Date(),
             updatedAt: Date()),
           TimeSensativeNotification(id: "2",
                                     title: "Socialization with People",
                                     category: .socialization,
                                     message: "It's time to start making sure your puppy is getting plenty of positive interactions with people. Hold off on socializing with other dogs until around 12 weeks.",
                                     deliverAtXWeeks: 8,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),
           TimeSensativeNotification(id: "3",
                                     title: "Microchipping",
                                     category: .health,
                                     message: "If you are considering geting your puppy microchiped, now is a good time.",
                                     deliverAtXWeeks: 12,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),
           TimeSensativeNotification(id: "4",
                                     title: "Introduction to New Environments",
                                     category: .socialization,
                                     message: "Start exposing your puppy to various new environments and situations.",
                                     deliverAtXWeeks: 14,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),


           TimeSensativeNotification(
               id: "5",
               title: "Vaccination Reminder",
               category: .health,
               message: "Your puppy is due for their first round of vaccinations. Make sure to schedule an appointment with your vet.",
               deliverAtXWeeks: 8,
               isRecurring: false,
               createdAt: Date(),
               updatedAt: Date()
           ),
          TimeSensativeNotification(
                id: "6",
                title: "Teething",
                category: .health,
                message: "Your puppy is entering the teething phase. Make sure to provide appropriate chew toys to soothe their gums.",
                deliverAtXWeeks: 12,
                isRecurring: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
           
           TimeSensativeNotification(id: "7",
                                     title: "Set Boundaries",
                                     category: .training,
                                     message: "It's important to establish boundaries with your puppy early on. Decide where your puppy is allowed to go in your home and start training them to respect these areas.",
                                     deliverAtXWeeks: 10,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),
           
           TimeSensativeNotification(id: "8",
                                         title: "Monthly Flea and Tick Prevention",
                                         category: .health,
                                         message: "It's time to administer your puppy's monthly flea and tick prevention medication.",
                                         deliverAtXWeeks: 8,
                                         isRecurring: true,
                                         recurrenceInterval: 4, // every 4 weeks
                                         createdAt: Date(),
                                         updatedAt: Date()),
            TimeSensativeNotification(
                id: "9",
                title: "Grooming Reminder",
                category: .grooming,
                message: "Your puppy's coat is growing thicker. It's time to start a regular grooming routine.",
                deliverAtXWeeks: 20,
                isRecurring: true,
                recurrenceInterval: 4,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "10",
                title: "Nutritional Advice",
                category: .health,
                message: "Your puppy is growing fast and needs a balanced diet. Make sure you are feeding them high-quality puppy food.",
                deliverAtXWeeks: 24,
                isRecurring: true,
                recurrenceInterval: 8,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "11",
                title: "Flea and Tick",
                category: .health,
                message: "It's time to apply your puppy's flea and tick prevention medication.",
                deliverAtXWeeks: 32,
                isRecurring: true,
                recurrenceInterval: 12,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "12",
                title: "Neutering/Spaying",
                category: .health,
                message: "Consider neutering or spaying your puppy. Consult your vet for the best time and procedure.",
                deliverAtXWeeks: 36,
                isRecurring: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "13",
                title: "Regular Vet Check",
                category: .health,
                message: "It's time for your puppy's regular vet check-up to ensure they are healthy and developing well.",
                deliverAtXWeeks: 48,
                isRecurring: true,
                recurrenceInterval: 24,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "14",
                title: "Outdoor Exercise Reminder",
                category: .exercise,
                message: "Your puppy has completed their vaccinations and is now ready for short, controlled outdoor walks. Regular exercise is important for their development, so make sure to take them for walks and outdoor playtime daily.",
                deliverAtXWeeks: 18,
                isRecurring: true,
                recurrenceInterval: 4,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "15",
                title: "Final Vaccinations Reminder",
                category: .health,
                message: "Your puppy is due for their final round of vaccinations. Make sure to schedule an appointment with your vet to ensure they are protected against common diseases.",
                deliverAtXWeeks: 16,
                isRecurring: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
            TimeSensativeNotification(
                id: "16",
                title: "Leash Training",
                category: .training,
                message: "It's time to start leash training your puppy. This is a crucial skill for them to learn for safe and controlled walks outside.",
                deliverAtXWeeks: 10,
                isRecurring: false,
                createdAt: Date(),
                updatedAt: Date()
            ),
           TimeSensativeNotification(id: "17",
                                     title: "Proper Socialization",
                                     category: .socialization,
                                     message: "Continue socializing your puppy with other dogs and people.",
                                     deliverAtXWeeks: 16,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),
           
           TimeSensativeNotification(id: "18",
                                     title: "Prevent Separation Anxiety",
                                     category: .socialization,
                                     message: "Start leaving your puppy alone for short periods to prevent separation anxiety.",
                                     deliverAtXWeeks: 10,
                                     isRecurring: false,
                                     createdAt: Date(),
                                     updatedAt: Date()),
        TimeSensativeNotification(
                id: "19",
                title: "Handling Sensitization",
                category: .grooming,
                message: "Gently handle your puppy's paws, ears, and mouth regularly. This will make them more comfortable with being handled and will make future grooming and veterinary visits easier.",
                deliverAtXWeeks: 10,
                isRecurring: true,
                recurrenceInterval: 4,
                createdAt: Date(),
                updatedAt: Date()
            )
    ]
}
