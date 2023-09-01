//
//  ServiceManager.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation
import Combine
import AppTrackingTransparency
import AdSupport

// Service Manager
class ServiceManager: ObservableObject {
    // Initialize services
    let firebaseService = FirebaseService.sharedInstance
    let userService = UserService.sharedInstance
    let notificationService = NotificationService.sharedInstance
    let purchaseService = PurchaseService.sharedInstance
    let signInWithAppleService = AppleSignInService.sharedInstance

    @Published var isConfigured = false
    @Published var showTabBar = false
    

    func configure() async {
        do {
            // Do any other configuration here
            if self.firebaseService.isAuthenticated {
                self.configureFromSuccessfulAuth()
            } else {
                DispatchQueue.main.async {
                    self.isConfigured = true
                }
            }
        } catch {
            print(error)
        }
    }

    
    func configureFromSuccessfulAuth() {
        self.userService.getUser { user, error in
            guard let u = self.userService.user else {
                DispatchQueue.main.async {
                    self.isConfigured = true
                    self.requestTrackingAuthorization()
                }
                
                return
            }
            
            self.requestTrackingAuthorization()

            //UpdateSubscription status
            var newUser = u
            //We should never change the lifetime flag!
            if newUser.subscriptionType != .lifetime, newUser.subscriptionType != self.purchaseService.subscriptionType {
                newUser.subscriptionType = self.purchaseService.subscriptionType
                self.userService.updateUser(user: newUser)
            }
            
            BetaService.sharedInstance.getEligibleUsers()
            
            CommandService.sharedInstance.loadCommands()
            CommandService.sharedInstance.saveCommands { error in
                print("Commands Saved")
            }
//                    LogService.sharedInstance.saveLogs { error in
//                        print("Logs saved")
//                    }
            
            NotificationService.sharedInstance.saveTimeSensitiveNotifications { error in
                print(error)
            }
            
            NotificationService.sharedInstance.fetchUserNotifications { userNotification, error in
                NotificationService.sharedInstance.checkForNotificationsToSend(puppyBirthday: UserService.sharedInstance.user?.birthdate ?? Date(), notifications: NotificationService.sharedInstance.timeSensitiveNotifications)
            }
            
            LogService.sharedInstance.fetchPuppyLogs()
            
            CommandService.sharedInstance.fetchUserCommands { userCommands, error in
                self.isConfigured = true
                print(userCommands)
            }
        }
    }
    
    func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            // handle the authorization status
            switch status {
            case .authorized:
                // Tracking authorization dialog was shown
                // and permission has been granted.
                print("Permission granted.")
                print(ASIdentifierManager.shared().advertisingIdentifier)
            
            case .denied:
                // Tracking authorization dialog was
                // shown and permission has been denied.
                print("Permission denied.")
            
            case .notDetermined:
                // Tracking authorization dialog has not been shown.
                print("Permission not determined.")
            
            case .restricted:
                // The device is not eligible for tracking.
                print("Permission restricted.")
            
            @unknown default:
                print("Unknown status.")
            }
        })
    }
}
