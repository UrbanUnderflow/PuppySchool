//
//  PackageViewModel.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/20/23.
//

import Foundation
import RevenueCat

struct PackageViewModel: Identifiable {
    
    let package: Package
    
    var id: String {
        package.identifier
    }
    
    var title: String? {
        guard let subscriptionPeriod = package.storeProduct.subscriptionPeriod else {
            return nil
        }
        
        switch subscriptionPeriod.unit {
        case .month:
            return "Monthly"
        case .year:
            return "Yearly"
        default:
            return "Lifetime"
        }
    }
    
    var price: String {
        package.storeProduct.localizedPriceString
    }
}
