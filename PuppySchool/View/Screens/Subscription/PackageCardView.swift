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
    
    var package: PackageViewModel?
    
    @ObservedObject var offeringViewModel: OfferingViewModel
    @Binding var selectedPackage: PackageViewModel?

    var onSelected: (PackageViewModel) -> Void
    
    var body: some View {
        Button {
            if let pack = package {
                onSelected(pack)
            }
        } label: {
            ZStack {
                Color.darkPurple

                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(title)
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                Text(breakDownPrice)
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 5)
                            
                            Text(subtitle)
                                .padding(.horizontal)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 10)
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .top], 10)
                    .padding(.bottom, 20)
                }
                .foregroundColor(selectedPackage?.package == package?.package ? Color.secondaryPink : Color.secondaryWhite)
            }
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedPackage?.package == package?.package ? Color.secondaryPink : Color.gray, lineWidth: 1) // Conditional border color
            )
            .padding(.horizontal, 10)
        }

    }
}

struct PackageCardView_Previews: PreviewProvider {
    static var previews: some View {
        PackageCardView(badgeLabel: "Pay Once", title: "Lifetime", subtitle: "Pay once and get access to top notch dog training, forever!", breakDownPrice: "Free 7 day trial, \nthen $79.99", billPrice: "Ont-Time Purchase", bottomLabel: "No subscription", buttonTitle: "Get Lifetime", package: nil, offeringViewModel: OfferingViewModel(), selectedPackage: .constant(nil)) { package in
            print(package)
            //check the status of subscription before moving forwad with this purchase
            
            
        }
    }
}
