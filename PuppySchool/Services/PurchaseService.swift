//
//  PurchaseService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import Foundation
import Combine
import RevenueCat

enum CustomError: Error {
    case noPurchaserInfo
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .noPurchaserInfo:
            return "No purchaser info available"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}

final class PurchaseService: NSObject, PurchasesDelegate {
    
    static let sharedInstance = PurchaseService()
    let offering = OfferingViewModel.sharedInstance
    var subscriptionType: SubscriptionType = .free

    @Published private(set) var isSubscribed = false
    
    var subscribedPublisher: AnyPublisher<Bool, Never> {
        $isSubscribed.eraseToAnyPublisher()
    }
    
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        guard let entitlement = customerInfo.entitlements.all["plus"] else {
            isSubscribed = false
            return
        }
        
        isSubscribed = entitlement.isActive
    }
    
    func checkSubscriptionStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            if let error = error {
                completion(.failure(error))
            } else if let purchaserInfo = purchaserInfo {
                let isSubscribed = purchaserInfo.entitlements["plus"]?.isActive == true
                self.updateUserSubscription(identifier: purchaserInfo.entitlements["plus"]?.productIdentifier ?? "")
                if UserService.sharedInstance.isBetaUser == true {
                    self.isSubscribed = true
                } else {
                    self.isSubscribed = isSubscribed
                }
                completion(.success(self.isSubscribed))
            } else {
                self.isSubscribed = false
                completion(.failure(CustomError.noPurchaserInfo))
            }
        }
    }
    
    func restorePurchases(completion: @escaping (Result<Bool, Error>) -> Void) {
        Purchases.shared.restorePurchases { (purchaserInfo, error) in
            if let error = error {
                completion(.failure(error))
            } else if let purchaserInfo = purchaserInfo {
                let isSubscribed = purchaserInfo.entitlements["plus"]?.isActive == true
                self.updateUserSubscription(identifier: purchaserInfo.entitlements["plus"]?.productIdentifier ?? "")
                if UserService.sharedInstance.isBetaUser == true {
                    self.isSubscribed = true
                } else {
                    self.isSubscribed = isSubscribed
                }
                completion(.success(self.isSubscribed))
            } else {
                self.isSubscribed = false
                completion(.failure(CustomError.noPurchaserInfo))
            }
        }
    }
    
    func updateUserSubscription(identifier: String) {
        switch identifier {
        case "ps_1299_1m":
            subscriptionType = .monthly
        case "ps_7999_1y":
            subscriptionType = .annual
        default:
            break
        }
    }
}
