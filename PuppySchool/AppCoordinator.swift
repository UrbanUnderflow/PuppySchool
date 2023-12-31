//
//  AppCoordinator.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import Foundation
import SwiftUI
import RevenueCat
import AuthenticationServices
import Firebase

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
        case aboutScreen
        case terms
        case privacyPolicy
        case settings
        case calendar(viewModel: CalendarViewModel)
        case commandDetail(command: Command)
        case alert(viewModel: NotificationPanelViewModel)
        case payWall
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
                delay(0.5) {
                    self.serviceManager.firebaseService.createUserObject()
                }
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
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signInWithApple(completion: @escaping (Result<String, Error>) -> Void) {
        serviceManager.signInWithAppleService.onSignIn = { [weak self] result in
                switch result {
                case .success(let idTokenString):
                    self?.serviceManager.firebaseService.signInWithApple(idTokenString: idTokenString) { result in
                        switch result {
                        case .success(_):
                            completion(.success("success"))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            // Start the sign-in operation
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = serviceManager.signInWithAppleService
            authorizationController.presentationContextProvider = serviceManager.signInWithAppleService
            authorizationController.performRequests()

    }
    
    func handleLogout() {
        // Sign out the user and move back to the login screen
        do {
            try serviceManager.firebaseService.signOut()
            serviceManager.userService.user = nil
            serviceManager.isConfigured = false
            serviceManager.showTabBar = false
            
            // Clear all user defaults
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
        } catch let error {
            print(error)
        }
        showIntroScreen()
    }

    
    func handleLoginSuccess() {
        guard let user = Auth.auth().currentUser else {
            print("Weird user issue. User is not detected")
            return
        }
        
        Purchases.shared.logIn(user.uid) { (purchaserInfo, error, publicError) in
            // handle any error.
            print(error)
        }
        
        Task {
            try await serviceManager.configure()

            PurchaseService.sharedInstance.checkSubscriptionStatus { [weak self] (result) in
                switch result {
                case .success(let isSubscribed):
                    let userService = UserService.sharedInstance
                    
                    if isSubscribed {
                        self?.showHomeScreen()
                        UserService.sharedInstance.isSubscribed = true
                    } else {
                        if !userService.settings.hasIntroductionModalShown {
                            self?.showHomeScreen()
                        } else {
                            self?.showPayWall()
                            UserService.sharedInstance.isSubscribed = false
                        }
                    }
                case .failure(let error):
                    // Handle the error here
                    print("Error checking subscription status: \(error)")
                }
            }
        }        
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
        self.serviceManager.showTabBar = true
    }
    
    func showLogScreen() {
        currentScreen = .log
    }
    
    func showChecklistScreen() {
        currentScreen = .checklist
    }
    
    func showPayWall() {
        currentScreen = .payWall
        self.serviceManager.showTabBar = false
        modalScreen = nil
    }
    
    func showAppIntro() {
        currentScreen = .appIntro
        self.serviceManager.showTabBar = false
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
    
    func showPayWallModal() {
        modalScreen = .payWall
    }
    
    func showCalendarModal(viewModel: CalendarViewModel) {
        modalScreen = .calendar(viewModel: viewModel)
    }
    
    func showAboutScreenModal() {
        modalScreen = .aboutScreen
    }
    
    func showTermsScreenModal() {
        modalScreen = .terms
    }
    
    func showPrivacyScreenModal() {
        modalScreen = .privacyPolicy
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
    
    func showAlertPanelModal(viewModel: NotificationPanelViewModel) {
        modalScreen = .alert(viewModel: viewModel)
    }
    
    func showSettingsModal() {
        modalScreen = .settings
    }
    
    //notifiationd/
    
    func showNotificationModal(viewModel: CustomModalViewModel) {
        notificationScreen = .notification(viewModel: viewModel)
    }
    
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
                                await PurchaseService.sharedInstance.offering.start()
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
                    .onAppear {
                        serviceManager.requestTrackingAuthorization()
                    }
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
        case .payWall:
            return AnyView(
                PayWallView(viewModel: PayWallViewModel(appCoordinator: appCoordinator))
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
        
        case .settings:
            return AnyView(EmptyView())
        case .alert(viewModel: let viewModel):
            return AnyView(EmptyView())
        }
    }
}

