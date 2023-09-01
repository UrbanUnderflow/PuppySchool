//
//  HomeView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager
    
    @Published var showLoader = false
    @Published var titles: [String] = []
    @Published var filterBy = FilterByType.category
    @Published var currentProgress: CGFloat = 0.0
    
    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
        
        updateTitles()
    }
    
    func updateTitles() {
        let commands = CommandService.sharedInstance.commands
        
        switch filterBy {
        case .category:
            let predefinedOrder: [CommandCategory] = [.startHere, .foundational, .obedience, .safety, .playful, .task, .advanced]
            titles = commands.map { $0.category.rawValue }
            titles.sort { (a, b) -> Bool in
                if let indexA = predefinedOrder.firstIndex(of: CommandCategory(rawValue: a) ?? .foundational), let indexB = predefinedOrder.firstIndex(of: CommandCategory(rawValue: b) ?? .foundational) {
                    return indexA < indexB
                }
                return false
            }
        case .difficulty:
            let predefinedOrder: [Difficulty] = [.beginner, .intermediate, .advanced] // replace with your actual types
            titles = commands.map { $0.difficulty.rawValue }
            titles.sort { (a, b) -> Bool in
                if let indexA = predefinedOrder.firstIndex(of: Difficulty(rawValue: a) ?? .advanced), let indexB = predefinedOrder.firstIndex(of: Difficulty(rawValue: b) ?? .advanced) {
                    return indexA < indexB
                }
                return false
            }
        case .environment:
            let predefinedOrder: [Environment] = [.indoor, .outdoor, .social] // replace with your actual types
            titles = commands.map { $0.environment.rawValue }
            titles.sort { (a, b) -> Bool in
                if let indexA = predefinedOrder.firstIndex(of: Environment(rawValue: a) ?? .indoor), let indexB = predefinedOrder.firstIndex(of: Environment(rawValue: b) ?? .indoor) {
                    return indexA < indexB
                }
                return false
            }
        case .stage:
            let predefinedOrder: [DogStage] = [.puppy, .adolescent, .adult] // replace with your actual types
            titles = commands.map { $0.dogStage.rawValue }
            titles.sort { (a, b) -> Bool in
                if let indexA = predefinedOrder.firstIndex(of: DogStage(rawValue: a) ?? .adolescent), let indexB = predefinedOrder.firstIndex(of: DogStage(rawValue: b) ?? .adolescent) {
                    return indexA < indexB
                }
                return false
            }
        }
        
        titles = titles.removeDuplicates()
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
    
    var notificationBell: some View {
        ZStack {
            Circle()
                .fill(Color.secondaryWhite)
                .frame(width: 50, height:50)
            IconImage(.customIcon(.notification, color: .black))
            
            if NotificationService.sharedInstance.userNotifications.filter({$0.wasDelivered == false }).count != 0 {
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .offset(x: 6)
                    .offset(y: -8)
            }
        }
    }
    
    var topBar: some View {
        HStack {
            RemoteImage(url: UserService.sharedInstance.user?.profileImageURL ?? "", placeHolderImage: .customIcon(.dog, color: .secondaryWhite), width: 80, height:80, cornerRadius: 40)
                .padding(.leading, 20)
            
            VStack(alignment: .leading) {
                Text("Good Day!")
                    .foregroundColor(.secondaryWhite)
                    .font(.headline)
                    .bold()
                Text("\(UserService.sharedInstance.user?.dogName.capitalized ?? "Hendrix") is ready for \ntraining.")
                    .foregroundColor(.secondaryWhite)
                    .font(.subheadline)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            notificationBell
            .padding(.trailing, 20)
            .onTapGesture {
                var notifications = NotificationService.sharedInstance.userNotifications
                
                viewModel.appCoordinator.showAlertPanelModal(
                    viewModel:
                        NotificationPanelViewModel(appCoordinator: viewModel.appCoordinator, notifications: notifications))
            }
        }
    }
    
    var inProgressModule: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Currently Learning")
                        .font(.subheadline)
                        .foregroundColor(.secondaryWhite)
                        .padding(.bottom, 8)
                    HStack {
                        Text(CommandService.sharedInstance.previousCommand?.command.category.rawValue ?? "Foundational Behaviors")
                            .foregroundColor(.secondaryWhite)
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text("View All")
                            .foregroundColor(.secondaryWhite)
                            .font(.subheadline)
                    }
                    .padding(.bottom, 20)
                    HStack(alignment: .center, spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(randomShadeColor())
                                .frame(width: 85, height: 85)
                            IconImage(
                                .commandIcon(DogCommandIcon(rawValue: "\(CommandService.sharedInstance.previousCommand?.command.icon.rawValue ?? "").SFSymbol") ?? .sit, color: .secondaryWhite),
                                width: 40,
                                height: 40)
                            
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            Text(CommandService.sharedInstance.previousCommand?.command.name ?? "")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.secondaryWhite)
                                .padding(.bottom, 5)
                            HStack(alignment: .center) {
                                ProgressBar(progress: CommandService.sharedInstance.previousCommand?.calculateProgress() ?? 0.0, color: .secondaryWhite, backgroundColor: .darkPurple)
                                    .frame(width: .infinity, height: 10)
                                Spacer()
                                    .frame(width: 20)
                                IconImage(.sfSymbol(.chevRight, color: .secondaryWhite), width: 14, height: 14)
                            }
                            .padding(.bottom, 8)
                            
                            Text("\(CommandService.sharedInstance.previousCommand?.command.difficulty.rawValue.capitalized ?? "Advanced")")
                                .font(.subheadline)
                                .foregroundColor(.secondaryWhite)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                            
                                .background(BadgeBackground(color: randomShadeColor(), cornerRadius: 10))
                        }
                        
                    }
                    
                }
                Spacer()
            }
            .padding(.bottom, 10)
            
            ConfirmationButton(title: "Continue Training", type: .primaryLargeGradientConfirmation) {
                if let command = CommandService.sharedInstance.previousCommand?.command {
                    viewModel.appCoordinator.showCommandDetailModal(command:  command)
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                if let _ = CommandService.sharedInstance.previousCommand {
                    VStack {
                        HStack {
                            Spacer()
                            IconImage(.custom(.backgroundImage1))
                                .frame(width: 250)
                                .padding(.top, 200)
                                .offset(x: 50)
                        }
                        Spacer()
                    }
                }
                VStack {
                    topBar
                        .padding(.top, 40)
                    //                DropDownFilterView(viewModel: DropDownFilterViewModel(filterBy: .category))
                    if let prevCommand = CommandService.sharedInstance.previousCommand {
                        if prevCommand.calculateProgress() != 1 {
                            inProgressModule
                                .padding(.vertical, 30)
                                .padding(.horizontal, 20)
                        }
                    }
                    
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
                .background(.clear)
            }
        }
        .background(Color.primaryPurple)
        .onAppear {
            let userService = UserService.sharedInstance
            delay(1) {
                if !userService.settings.hasIntroductionModalShown {
                    viewModel.appCoordinator.showRegisterModal()
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



