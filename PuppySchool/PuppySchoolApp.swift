//
//  PuppySchoolApp.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//
import SwiftUI
import FirebaseCore
//import RevenueCat

@main
struct PuppySchoolApp: App {
    @StateObject private var serviceManager = ServiceManager()

    init() {
//        Purchases.configure(withAPIKey: "appl_maHHKNMgjAMzVzOLYXHnimVWEuX")
//        Purchases.logLevel = .info
//        Purchases.logLevel = .verbose //set to info for production
      //  Purchases.shared.delegate = serviceManager.purchaseService
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(serviceManager: serviceManager)
            }
        }
    }
}
