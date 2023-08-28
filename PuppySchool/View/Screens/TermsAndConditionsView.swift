//
//  TermsAndConditionsView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 7/23/23.
//

import Foundation
import SwiftUI

class TermsConditionsViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct TermsConditionsView: View {
    @ObservedObject var viewModel: TermsConditionsViewModel

    var body: some View {
        VStack {
            HStack {
                CloseButtonView {
                    viewModel.appCoordinator.closeModals()
                }
                .padding(.leading, 20)
                .padding(.top, 50)
                Spacer()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("Terms and Conditions")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("By using Puppy School, you are agreeing to the following terms and conditions.")
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Usage Responsibilities:")
                            .font(.title2)
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("You are responsible for your own account and all activity occurring under it. You must use Puppy School in compliance with all laws, regulations, and rules.")
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                    }
                    
                    Group {
                        Text("Veterinary Disclaimer:")
                            .font(.title2)
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("The advice provided by Puppy School is not a substitute for professional veterinary advice. We are not veterinarians. Consult with a professional veterinarian before making any decisions concerning your pet’s health.")
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Content Rights:")
                            .font(.title2)
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Puppy School retains rights to all content uploaded to the app and can use it for improving the service, research, and promotional purposes.")
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Intellectual Property:")
                            .font(.title2)
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                        
                        Text("Puppy School owns all intellectual property rights in and to the service, including but not limited to text, graphics, logos, and software. Users are prohibited from copying, distributing, or creating derivative works without the express permission of Puppy School.")
                            .foregroundColor(.secondaryWhite)
                            .padding()
                            .multilineTextAlignment(.leading)
                    }
                    
                    // Add more specific terms as required...
                    
                    Spacer()
                }
            }
        }
        .background(Color.secondaryCharcoal)
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
    }
}
