//
//  CustomTabBarView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/30/23.
//

import SwiftUI

enum Tab {
    case home, log, list, profile
}

class CustomTabBarViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
        
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct CustomTabBarView: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            Divider(color: .gray, height: 1)
            HStack {
                TabButton(
                    icon: IconImage(.custom(selectedTab == .home ? .taskbarPawSelected : .taskbarPaw)),
                        text: "Training",
                        isSelected: selectedTab == .home,
                        action: {
                            selectedTab = .home
                            viewModel.appCoordinator.showHomeScreen()
                        },
                        color: .secondaryPink
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(.custom(selectedTab == .log ? .taskbarLogSelected : .taskbarLog)),
                        text: "Log",
                        isSelected: selectedTab == .log,
                        action: {
                            selectedTab = .log
                            viewModel.appCoordinator.showLogScreen()
                        },
                        color: .secondaryPink
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(selectedTab == .list ? .custom(.taskbarListSelected) : .custom(.taskbarList)),
                        text: "List",
                        isSelected: selectedTab == .list,
                        action: {
                            selectedTab = .list
                            viewModel.appCoordinator.showChecklistScreen()
                        },
                        color: .secondaryPink
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(selectedTab == .profile ?
                        .sfSymbol(.personFill, color:  .secondaryPink) :
                        .sfSymbol(.person, color:  .secondaryWhite)),
                        text: "Profile",
                        isSelected: selectedTab == .profile,
                        action: {
                            selectedTab = .profile
                            viewModel.appCoordinator.showProfile()
                        },
                        color: .secondaryPink
                )
                .padding(.horizontal)
                
            }
            .padding()
            .background(Color.primaryPurple.opacity(0.9))
        }
    }
}

private struct TabButton: View {
    var icon: IconImage
    var text: String
    var isSelected: Bool
    var action: () -> Void
    var color: Color

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            VStack {
                icon
                .frame(width: 24, height: 24)
                Text(text)
                    .bold()
                    .font(.subheadline)
            }
            .foregroundColor(isSelected ? color : .secondaryWhite)
        }
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(viewModel: CustomTabBarViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}

