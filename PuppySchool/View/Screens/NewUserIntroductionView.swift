//
//  NewIntroductionView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation
import SwiftUI

struct Feature: Identifiable {
    var id = UUID()
    var icon: Icon
    var title: String
    var description: String
    var background: Color
}

struct FeatureView: View {
    var feature: Feature
    
    var body: some View {
            VStack {
                VStack(spacing: 0) {
                    IconImage(feature.icon)
                        .padding()
                    
                    Text(feature.title)
                        .font(.title)
                        .foregroundColor(.secondaryWhite)
                        .bold()
                        .padding()
                    
                    Text(feature.description)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundColor(.secondaryWhite)
                }
                .padding(.horizontal)
                Spacer()
            }
    }
}

class NewUserIntroductionViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct NewUserIntroductionView: View {
    @State var selection: Int = 0
    @ObservedObject var viewModel: NewUserIntroductionViewModel
    @State private var background: Color = randomShadeColor()

    
    let features = [
        Feature(icon: .custom(.commandPreview), title: "Training", description: "Train your puppy, through simple single commands.", background: Color.primaryPurple),
        Feature(icon: .custom(.sitCommand), title: "Choose Command", description: "Choose the command you want to teach your puppy.", background: Color.primaryPurple),
        Feature(icon: .custom(.clickerTraining), title: "Performing Commands", description: "Follow the steps, and tap the clicker button, and reward with a treat immediately after the puppy performs the command.", background: Color.primaryPurple),
        Feature(icon: .custom(.logImage), title: "Doggy Journal", description: "Keep entries of important events throughout the day to start creating a puppy schedule.", background: Color.primaryPurple),
        Feature(icon: .custom(.listImage), title: "Doggy Essentials", description: "Get a list of essential items that are relevant to the age/ stage of your puppy.", background: Color.primaryPurple),
        Feature(icon: .custom(.alertImage), title: "Time-Senative Alerts", description: "Know when it's time to teach your puppy new skills, take them to the vet, or introduce them to new experiences.", background: Color.primaryPurple)

    ]
    var body: some View {
        ZStack {
            self.background
            VStack {
                Spacer()
                    .frame(height: 80)
                
                CustomTabViewIndicator(selection: $selection, tabCount: features.count, dotColor: .white)
                TabView(selection: $selection) {
                    ForEach(Array(features.enumerated()), id: \.offset) { index, feature in
                        FeatureView(feature: feature)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onChange(of: selection) { newValue in
                    background = randomDarkerShadeColor()
                }
                
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    if selection == (features.count - 1) {
                        ConfirmationButton(title: "Get Started", type: .secondaryLargeConfirmation) {
                            viewModel.appCoordinator.showPayWall()
                            UserService.sharedInstance.settings.hasIntroductionModalShown = true
                        }
                        .padding(.horizontal, 20)
                    } else {
                        ConfirmationButton(title: "Skip", type: .clearButtonBold) {
                            viewModel.appCoordinator.showPayWall()
                            UserService.sharedInstance.settings.hasIntroductionModalShown = true
                        }
                    }
                }
                .padding(.bottom, 50)

                
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct NewUserIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserIntroductionView(viewModel: NewUserIntroductionViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}


