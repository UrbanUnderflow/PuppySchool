//
//  PackageCardView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/24/23.
//

import SwiftUI
import RevenueCat

struct PackageCardView: View {
    var badgeLabel: String
    var title: String
    var subtitle: String
    var breakDownPrice: String
    var billPrice: String
    var bottomLabel: String
    var buttonTitle: String
    
    var package: PackageViewModel
    @ObservedObject var offeringViewModel: OfferingViewModel
    
    var onPurchase: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(badgeLabel)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .background(BadgeBackground(color: .blueGray, cornerRadius: 40))
                .padding(.top)
                .padding(.leading)
                
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text(title)
                        .font(.title2)
                    
                    Text(subtitle)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    Text(breakDownPrice)
                        .font(.headline)
                        .bold()
                    Text(billPrice)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    ConfirmationButton(title: buttonTitle, type: .primaryLargeConfirmation) {
                        onPurchase()
                    }
                    .padding(.horizontal)
                    Text(bottomLabel)
                        .padding(.bottom)
                    
                    Spacer()
                }
                .background(CardBackground(color: .secondaryWhite))
                .frame(width: 360, height: 400)
                .padding(.horizontal, 1)
            }
        }
    }
}

struct PackageCardView_Previews: PreviewProvider {
    static var previews: some View {
        PackageCardView(badgeLabel: "Pay Once", title: "Lifetime", subtitle: "Pay once and get access to top notch dog training, forever!", breakDownPrice: "$249", billPrice: "Ont-Time Purchase", bottomLabel: "No subscription", buttonTitle: "Get Lifetime", package: Package(), offeringViewModel: OfferingViewModel()) {
            
            //check the status of subscription before moving forwad with this purchase
            
        }
    }
}
