//
//  FreeTrialView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI
import RevenueCat
import Combine

class PayWallViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    @Published var monthPackage: PackageViewModel? = nil
    @Published var annualPackage: PackageViewModel? = nil
    @Published var lifeTimePackage: PackageViewModel? = nil
    
    @Published var selectedPackage: PackageViewModel?

    
    var offeringViewModel = PurchaseService.sharedInstance.offering
    var showErrorScreen: Bool = false
    var isTesting: Bool = false
    
    init(appCoordinator: AppCoordinator, isTesting: Bool = false) {
        self.appCoordinator = appCoordinator
        if let package = offeringViewModel.monthlyPackage {
            self.monthPackage = package
        } else {
            showErrorScreen = true
        }
        
        if let package = offeringViewModel.yearlyPackage {
            self.annualPackage = package
            self.selectedPackage = package
        } else {
            showErrorScreen = true
        }
        
        if let package = offeringViewModel.lifetimePackage {
            self.lifeTimePackage = package
        } else {
            showErrorScreen = true
        }
        
        if isTesting {
            showErrorScreen = false
        }
    }
    
    func checkSubscriptionStatus(completion: @escaping (Bool) -> Void) {
        
        if selectedPackage?.title != self.lifeTimePackage?.title {
            completion(true)
            return
        }
        
        PurchaseService.sharedInstance.checkSubscriptionStatus { [weak self] (result) in
            switch result {
            case .success(let isSubscribed):
                if isSubscribed {
                    self?.appCoordinator.showNotificationModal(viewModel: CustomModalViewModel(type: .confirmation, title: "Cancel your subscription", message: "You currently have an active subscription, make sure you cancel your subscription from your iPhone's Settings app under your Profile -> Subscriptions or it will renew automatically despite buying your Lifetime plan", primaryButtonTitle: "OK", secondaryButtonTitle: "Cancel", primaryAction: { message in
                        completion(true)
                    }, secondaryAction: {
                        completion(false)
                    }))
                } else {
                    completion(true)
                }
            case .failure(let error):
                self?.appCoordinator.showNotificationModal(viewModel: CustomModalViewModel(type: .confirmation, title: "Subscription attempt failed", message: "\(error.localizedDescription). You were not charged.", primaryButtonTitle: "OK", secondaryButtonTitle: "Cancel", primaryAction: { message in
                    completion(false)
                }))
            }
        }
    }
    
    func updateSubscriptionPlan(_ type: SubscriptionType) {
        if let user = UserService.sharedInstance.user {
            var newUser = user
            newUser.subscriptionType = type
            
            UserService.sharedInstance.updateUser(user: newUser)
        }
    }
    
}

struct PayWallView: View {
    @ObservedObject var viewModel: PayWallViewModel

    var selections: some View {
        VStack(spacing: 10) {
            PackageCardView(badgeLabel: "Most Flexible", title: "Monthly", subtitle: "Flexible, great for dogs that just need a bit of extra training.", breakDownPrice: "\(viewModel.monthPackage?.price ?? "") /month", billPrice: "Billed monthly", bottomLabel: "Great for limited training", buttonTitle: "Get Monthly", package: viewModel.monthPackage, offeringViewModel: viewModel.offeringViewModel, selectedPackage: $viewModel.selectedPackage) { package in
                viewModel.selectedPackage = package
            }

            PackageCardView(badgeLabel: "Best Value", title: "Yearly", subtitle: "The best training app for your new puppy with all our pro features.", breakDownPrice: "Free 7 day trial, \nthen \(viewModel.annualPackage?.price ?? "") /year", billPrice: "Start with a free 7 day trial", bottomLabel: "Most popular plan", buttonTitle: "Continue", package: viewModel.annualPackage, offeringViewModel: viewModel.offeringViewModel, selectedPackage: $viewModel.selectedPackage) { package in
                viewModel.selectedPackage = package
            }

            PackageCardView(badgeLabel: "Pay Once", title: "Lifetime", subtitle: "Pay once and get access to top notch dog training, forever!", breakDownPrice: "\(viewModel.lifeTimePackage?.price ?? "")", billPrice: "One-Time Purchase", bottomLabel: "No subscription", buttonTitle: "Get Lifetime", package: viewModel.lifeTimePackage, offeringViewModel: viewModel.offeringViewModel, selectedPackage: $viewModel.selectedPackage) { package in
                viewModel.selectedPackage = package
            }
            
            ConfirmationButton(title: "Get \(viewModel.selectedPackage?.title ?? "")", type: .primaryLargeGradientConfirmation) {
                
                //analytics event
                viewModel.appCoordinator.serviceManager.firebaseService.logPurchaseAttemptEvent(package: viewModel.selectedPackage?.title ?? "")
                
                //check the status of subscription before moving forwad with this purchase
                viewModel.checkSubscriptionStatus { isPermitted in
                    if isPermitted == true {
                        self.viewModel.appCoordinator.hideNotification()
                        
                        //analytics event
                        viewModel.appCoordinator.serviceManager.firebaseService.logPurchaseAttemptEvent(package: viewModel.selectedPackage?.title ?? "")
                        
                        viewModel.offeringViewModel.purchase(viewModel.selectedPackage!) { result in
                            switch result {
                            case .success:
                                print("Success")
                                print(viewModel.selectedPackage)
                                
                                viewModel.appCoordinator.serviceManager.firebaseService.logSuccessfulPurchase(package: "lifetime")
                                
                                viewModel.updateSubscriptionPlan(SubscriptionType.lifetime)
                                viewModel.appCoordinator.showHomeScreen()
                            case .failure(let error):
                                viewModel.appCoordinator.serviceManager.firebaseService.logFailedPurchase(package: "lifetime")
                                print("There was an error while purchasing \(error)")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 12)
            Text("After 7 days you're charged \(viewModel.selectedPackage?.price ?? "7.99")/ yearly")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
        }
    }
    
    var payWall: some View {
        ZStack {
            VStack {
                ScrollView {
                    ScrollViewReader { scrollProxy in
                        VStack(spacing: 0) {
                            VStack {
                                Text("Lead the Pack!")
                                    .foregroundColor(.secondaryWhite)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 70)
                                    .id(0)
                                
                                IconImage(.custom(.trophy))
                                    .frame(width: 120)
                                    .padding(.top, 10)
                                    
                                selections
                                 .padding(.horizontal, 8) // Add padding to the HStack to center the cards
                                 .padding(.top, 20)
                                 .padding(.bottom, 50)
                            }
                            .background(Color.primaryPurple)
                            
                            ZStack {
                                Circle()
                                    .fill(Color.lightGray)
                                    .frame(width: 50, height: 50)
                                IconImage(.sfSymbol(.downArrow, color: .darkPurple))
                            }
                            .offset(y: -25)

                            PreviewCardView()
                            
                            Spacer()
                                .frame(height: 50)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        IconImage(.sfSymbol(.upArrow, color: .primaryPurple))
                                        Text("Back to plans")
                                            .foregroundColor(.primaryPurple)
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            scrollProxy.scrollTo(0, anchor: .top)
                                        }
                                        
                                        viewModel.appCoordinator.serviceManager.firebaseService.logBackToPlansEvent()
                                    }
                                    HStack {
                                        IconImage(.sfSymbol(.reload, color: .gray))
                                        Text("Restore Purchases")
                                            .foregroundColor(.gray)
                                    }
                                    .onTapGesture {
                                        PurchaseService.sharedInstance.restorePurchases { result in
                                            switch result {
                                            case .success:
                                                viewModel.appCoordinator.showHomeScreen()
                                            case .failure(let error):
                                                print(error)
                                                viewModel.appCoordinator.showToast(viewModel: ToastViewModel(message: "We were unable to restore your purchase. Please contact support at puppyschoolapp@gmail.com", backgroundColor: .secondaryCharcoal, textColor: .secondaryWhite))
                                            }
                                        }
                                    }
                                    HStack {
                                        IconImage(.sfSymbol(.privacy, color: .gray))
                                        Text("Privacy Policy")
                                            .foregroundColor(.gray)
                                    }
                                    .onTapGesture {
                                        viewModel.appCoordinator.showPrivacyScreenModal()
                                    }
                                    HStack {
                                        IconImage(.sfSymbol(.doc, color: .gray))
                                        Text("Terms of Service")
                                            .foregroundColor(.gray)
                                    }
                                    .onTapGesture {
                                        viewModel.appCoordinator.showTermsScreenModal()
                                    }
                                    if BetaService.sharedInstance.betaEligibleUsers.contains(UserService.sharedInstance.user?.email ?? "nothing") {
                                        HStack {
                                            IconImage(.sfSymbol(.doc, color: .gray))
                                            Text("Enroll in Beta")
                                                .foregroundColor(.gray)
                                        }
                                        .onTapGesture {
                                            viewModel.appCoordinator.showHomeScreen()
                                        }
                                    } else {
                                        HStack {
                                            IconImage(.sfSymbol(.signOut, color: .gray))
                                            Text("Sign out")
                                                .foregroundColor(.gray)
                                        }
                                        .onTapGesture {
                                            viewModel.appCoordinator.handleLogout()
                                        }
                                    }
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, 50)
                                GeometryReader { geometry in
                                    Spacer()
                                        .frame(height: 100)
                                        .background(Color.clear) // Just to ensure it's transparent
                                        .onReceive(Just(geometry.frame(in: .global).minY)) { minY in
                                            if minY < UIScreen.main.bounds.height {
                                                viewModel.appCoordinator.serviceManager.firebaseService.logScrollToBottomOfPayWallEvent()
                                            }
                                        }
                                }
                            }
                            
                        }
                        Spacer()
                            .frame(height: 100)
                    }
                }
                .ignoresSafeArea(.all)
            }
            
            VStack {
                HStack {
                    if UserService.sharedInstance.isSubscribed == true {
                        BackButton()
                            .onTapGesture {
                                viewModel.appCoordinator.showHomeScreen()
                            }
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var body: some View {
        if viewModel.showErrorScreen {
            ErrorScreenView(viewModel: ErrorScreenViewModel(errorCode: .purchase))
        } else {
            payWall
        }
        
    }
}

struct PayWallView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView(viewModel: PayWallViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), isTesting: true))
    }
}
