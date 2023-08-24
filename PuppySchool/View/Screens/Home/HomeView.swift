//
//  HomeView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI

// Assuming your FilterByType looks something like this:
enum FilterByType: CaseIterable {
    case category, difficulty, environment, stage
}

class HomeViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager

    @Published var showLoader = false
    @Published var titles: [String] = []
    @Published var filterBy = FilterByType.category

    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
        updateTitles()
    }

    func updateTitles() {
        let commands = CommandService.sharedInstance.commands

        switch filterBy {
        case .category:
            titles = Set(commands.map { $0.category.rawValue }).sorted()
        case .difficulty:
            titles = Set(commands.map { $0.difficulty.rawValue }).sorted()
        case .environment:
            titles = Set(commands.map { $0.environment.rawValue }).sorted()
        case .stage:
            titles = Set(commands.map { $0.dogStage.rawValue }).sorted()
        }
    }
    
    func getTitleForFilterType(_ filterType: FilterByType) -> String {
        switch filterType {
        case .category:
            return "Category"
        case .difficulty:
            return "Difficulty"
        case .environment:
            return "Environment"
        case .stage:
            return "Dog Stage"
        }
    }

    func getCommandsByFilter(_ filterType: FilterByType, title: String) -> [Command] {
        switch filterType {
        case .category:
            return getCommandsByCategory(title)
        case .difficulty:
            return getCommandsByDifficulty(title)
        case .environment:
            return getCommandsByEnvironment(title)
        case .stage:
            return getCommandsByStage(title)
        }
    }

    func getCommandsByCategory(_ category: String) -> [Command] {
        let commands = CommandService.sharedInstance.commands
        
        return commands.filter { $0.category.rawValue == category }
    }
    
    func getCommandsByDifficulty(_ difficulty: String) -> [Command] {
        let commands = CommandService.sharedInstance.commands
        
        return commands.filter { $0.difficulty.rawValue == difficulty }
    }
    
    func getCommandsByEnvironment(_ environment: String) -> [Command] {
        let commands = CommandService.sharedInstance.commands
        
        return commands.filter { $0.environment.rawValue == environment }
    }
    
    func getCommandsByStage(_ dogStage: String) -> [Command] {
        let commands = CommandService.sharedInstance.commands
        
        return commands.filter { $0.dogStage.rawValue == dogStage }
    }
}

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            VStack {
                // Dropdown Picker
                HStack {
                    Spacer() // Center the menu
                    Menu {
                        ForEach(FilterByType.allCases, id: \.self) { filterType in
                            Button(action: {
                                viewModel.filterBy = filterType
                            }) {
                                Text(viewModel.getTitleForFilterType(filterType))
                            }
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color.ash) // Choose your preferred color
                                .frame(width: 200, height: 60)
                            HStack {
                                // You might not have the IconImage function, you can replace it with your own icon
                                Image(systemName: "arrowtriangle.down.fill") // SF Symbols down arrow icon
                                    .foregroundColor(.secondaryWhite)
                                Text(viewModel.getTitleForFilterType(viewModel.filterBy))
                                    .foregroundColor(.secondaryWhite)
                                    .font(.title3)
                                    .bold()
                            }
                        }
                    }.id(viewModel.filterBy)

                    Spacer()
                }
                .padding(.bottom, 20)
                
                ForEach(viewModel.titles, id: \.self) { title in
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical)
                        Spacer()
                    }
                    PhaseScroll(viewModel: PhaseScrollViewModel(commands: viewModel.getCommandsByFilter(viewModel.filterBy, title: title), userCommands: CommandService.sharedInstance.userCommands)) { command in
                        viewModel.appCoordinator.showCommandDetailModal(command: command)
                    }
                }
                .padding(.leading)
                Spacer()
                    .frame(height: 100)
            }
        }
        .background(Color.primaryPurple)
        .onAppear {
            let userService = UserService.sharedInstance
            
            delay(1) {
                if !userService.settings.hasIntroductionModalShown {
                    viewModel.appCoordinator.showRegisterModal()
                    userService.settings.hasIntroductionModalShown = true
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager()))
    }
}
