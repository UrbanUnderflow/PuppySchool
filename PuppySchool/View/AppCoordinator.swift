//
//  AppCoordinator.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import Foundation
import SwiftUI

protocol Screen {
    func makeView(serviceManager: ServiceManager, appCoordinator: AppCoordinator) -> AnyView
}

class AppCoordinator: ObservableObject {
    enum Screen {
        case splash
        case introView
        case registration
        case appIntro
        case home
        case log
        case checklist
        case changePassword
        case profile
        case freeTrial
        case aboutScreen
        case terms
        case privacyPolicy
        case calendar(viewModel: CalendarViewModel)
        case commandDetail(command: Command)
    }
    
    enum ToastNotification {
        case toast(viewModel: ToastViewModel)
    }
    
    enum NotificationScreen {
        case notification(viewModel: CustomModalViewModel)
    }
    
    @Published var currentScreen: Screen = .splash
    @Published var modalScreen: Screen?
    @Published var notificationScreen: NotificationScreen?
    @Published var toast: ToastNotification?

    @ObservedObject var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func handleLogin() {
        // Check if user is already authenticated, if yes move to the question screen
        if serviceManager.firebaseService.isAuthenticated {
            self.handleLoginSuccess()
        } else {
            showIntroScreen()
        }
    }
    
    func signUpUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        serviceManager.firebaseService.signUpWithEmailAndPassword(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.success("success"))
                self.serviceManager.showTabBar = true
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        serviceManager.firebaseService.signInWithEmailAndPassword(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.success("success"))
                self.serviceManager.showTabBar = true
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleLogout() {
        // Sign out the user and move back to the login screen
        do {
            try serviceManager.firebaseService.signOut()
            serviceManager.userService.user = nil
            serviceManager.isConfigured = false
            serviceManager.showTabBar = false
        } catch { error
            print(error)
        }
        showIntroScreen()
    }
    
    func handleLoginSuccess() {
        // Move to the question screen after successful login
        self.serviceManager.showTabBar = true
        showHomeScreen()
    }
    
    ///This is a setter screen to handle setting the screens and adding transitions
    func setCurrentScreen(_ newScreen: Screen) {
        withAnimation {
            currentScreen = newScreen
        }
    }
    
    
    // Show Screens
    func showSplashScreen() {
        setCurrentScreen(.splash)
    }
    
    /// Show screen functions
    func showIntroScreen() {
        setCurrentScreen(.introView)
    }
    
    
    func showChangePassword() {
        currentScreen = .changePassword
    }
    
    func showProfile() {
        currentScreen = .profile
    }
    
    func showHomeScreen() {
        currentScreen = .home
    }
    
    func showLogScreen() {
        currentScreen = .log
    }
    
    func showChecklistScreen() {
        currentScreen = .checklist
    }
    
    func showAppIntro() {
        currentScreen = .appIntro
    }
    
    //Modals
    func closeModals() {
        modalScreen = nil
    }
    
    func hideNotification() {
        notificationScreen = nil
    }
    
    func showToast(viewModel: ToastViewModel) {
        toast = .toast(viewModel: viewModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.toast = nil
        }
    }
    
    func showCalendarModal(viewModel: CalendarViewModel) {
        modalScreen = .calendar(viewModel: viewModel)
    }
    
    func hideToast() {
        toast = nil
    }
    
    func showCommandDetailModal(command: Command) {
        modalScreen = .commandDetail(command: command)
    }
    
    func showRegisterModal() {
        modalScreen = .registration
    }
    
    //notifiationd/
    
    func showLogAnEventModal() {
        notificationScreen = .notification(viewModel: CustomModalViewModel(type: .log, title: "Choose an event", message: "What time did this occur?", primaryButtonTitle: "Log", primaryAction: { message in
            self.hideNotification()
            self.showToast(viewModel: ToastViewModel(message: "Your log has been added successfully", backgroundColor: .secondaryCharcoal, textColor: .secondaryWhite))
        }, secondaryAction: {
            self.hideNotification()
        }))
    }

}

extension AppCoordinator.Screen: Screen {
    func makeView(serviceManager: ServiceManager, appCoordinator: AppCoordinator) -> AnyView {
        switch self {
        case .splash:
            return AnyView(
                SplashLoader(viewModel: SplashLoaderViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
                    .onAppear {
                        Task {
                            do {
                                try await serviceManager.configure()
                                await Task.sleep(5 * 1_000_000_000) // Wait for 5 seconds
                                await appCoordinator.handleLogin()
                            } catch {
                                print("Configuration failed: \(error)")
                            }
                        }
                    }
            )
        case .introView:
            return AnyView(
                IntroView(viewModel: IntroViewViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
            )
        case .appIntro:
            return AnyView(
                NewUserIntroductionView(viewModel: NewUserIntroductionViewModel(appCoordinator: appCoordinator))
            )
        case .home:
            return AnyView(
                HomeView(viewModel: HomeViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager))
            )
        case .changePassword:
            return AnyView(
                ChangePasswordView(viewModel: ChangePasswordViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager))
            )
        case .profile:            
            return AnyView(
                ProfileView(viewModel: ProfileViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
            )
        case .registration:
            return AnyView(
                RegistrationView()
            )
        case .freeTrial:
            return AnyView(
                FreeTrialView()
            )
        case .aboutScreen:
            return AnyView(EmptyView())
        case .terms:
            return AnyView(EmptyView())
        case .privacyPolicy:
            return AnyView(EmptyView())
        case .commandDetail(let command):
            return AnyView(EmptyView())
        case .log:
            return AnyView(
                LogView(viewModel: LogViewModel(appCoordinator: appCoordinator,
                                                serviceManager: serviceManager,
                                                logs: LogService.sharedInstance.puppyLogs,
                                                filteredLogs: LogService.sharedInstance.filteredPuppyLogs))
            )
        case .checklist:
            return AnyView(
                CheckListView(viewModel: CheckListViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager, checklistItems:
                    CheckListService.sharedInstance.checklistItems
                ))
            )
        case .calendar(viewModel: let viewModel):
            return AnyView(EmptyView())
        }
    }
}

