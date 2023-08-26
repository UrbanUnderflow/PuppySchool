//
//  ProfileView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/21/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var serviceManager: ServiceManager
    @Published var appCoordinator: AppCoordinator
    
    init(serviceManager: ServiceManager, appCoordinator: AppCoordinator) {
        self.serviceManager = serviceManager
        self.appCoordinator = appCoordinator
    }
    
}
struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text(UserService.sharedInstance.user?.dogName.capitalized ?? "")
                        .font(.largeTitle)
                        .foregroundColor(Color.secondaryWhite)
                        .bold()
                    Spacer()
                    IconImage(.sfSymbol(.settings, color: .secondaryWhite))
                        .onTapGesture {
                            viewModel.appCoordinator.showSettingsModal()
                        }
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
                RemoteImage(url: UserService.sharedInstance.user?.profileImageURL ?? "", placeHolderImage: .customIcon(.dog, color: .lightGray), width: 120, height: 120, cornerRadius: 60)
                    .padding(.bottom, 100)

                Text("Streak")
                    .font(.title3)
                    .foregroundColor(.secondaryWhite)
                    .bold()
                    .padding(.bottom, 20)
                ProfileMenuItemView(viewModel: ProfileMenuItemViewModel(title: "CURRENT", value: "\(determineStreak())"))
                    .padding(.bottom, 16)
                ProfileMenuItemView(viewModel: ProfileMenuItemViewModel(title: "ALL TIME RECORD", value: "\(determineAllTimeHighestStreak())"))
                    .padding(.bottom, 20)
                
                Text("Mastered Skills (\(countMasteredCommands()))")
                    .font(.title3)
                    .foregroundColor(.secondaryWhite)
                    .bold()
                    .padding(.bottom, 20)
                
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(CommandService.sharedInstance.commands, id: \.self) { command in
                        MasteredSkillBadgeView(viewModel: MasteredSkillBadgeViewModel(badge: MasteredBadge(id: UUID().uuidString, icon: command.icon), isMastered: isSkillMastered(command: command)))
                            .padding()
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            Spacer()
                .frame(height: 100)
        }
        .background(Color.primaryPurple, ignoresSafeAreaEdges: .all)
    }
    
    func isSkillMastered(command: Command) -> Bool {
        let userCommands = CommandService.sharedInstance.userCommands
        let currentUserCommand = userCommands.filter { $0.command.id == command.id }.first
        
        if let c = currentUserCommand {
            if c.calculateProgress() == 1 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func countMasteredCommands() -> Int {
        var masteredCommands = 0
        
        for command in CommandService.sharedInstance.commands {
            if isSkillMastered(command: command) {
                masteredCommands += 1
            }
        }
        
        return masteredCommands
    }
    
    func determineStreak() -> Int {
        let logs = LogService.sharedInstance.puppyLogs
        guard !logs.isEmpty else { return 0 }

        // Sort logs by createdAt in ascending order
        let sortedLogs = logs.sorted { $0.createdAt < $1.createdAt }

        var streak = 1
        var currentStreak = 1

        let calendar = Calendar.current

        for i in 1..<sortedLogs.count {
            let previousDate = sortedLogs[i-1].createdAt
            let currentDate = sortedLogs[i].createdAt

            // Check if the two dates are consecutive days
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: previousDate),
               calendar.isDate(nextDate, inSameDayAs: currentDate) {
                currentStreak += 1
                streak = max(streak, currentStreak)
            } else {
                currentStreak = 1
            }
        }

        return streak
    }
    
    func determineAllTimeHighestStreak() -> Int {
        let logs = LogService.sharedInstance.puppyLogs
        guard !logs.isEmpty else { return 0 }

        // Sort logs by createdAt in ascending order
        let sortedLogs = logs.sorted { $0.createdAt < $1.createdAt }

        var highestStreak = 0
        var currentStreak = 1

        let calendar = Calendar.current

        for i in 1..<sortedLogs.count {
            let previousDate = sortedLogs[i-1].createdAt
            let currentDate = sortedLogs[i].createdAt

            // Check if the two dates are consecutive days
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: previousDate),
               calendar.isDate(nextDate, inSameDayAs: currentDate) {
                currentStreak += 1
            } else {
                highestStreak = max(highestStreak, currentStreak)
                currentStreak = 1
            }
        }

        highestStreak = max(highestStreak, currentStreak)

        return highestStreak
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(serviceManager: ServiceManager(),
                                                appCoordinator: AppCoordinator(serviceManager: ServiceManager())
                                               )
        )
    }
}
