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
                    Text(UserService.sharedInstance.user?.dogName ?? "")
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
                RemoteImage(url: "https://firebasestorage.googleapis.com/v0/b/puppyschool-a2c26.appspot.com/o/Hentrix.jpg?alt=media&token=a3364eed-633e-4a44-bb9d-aab1f21993e4")
                    .frame(width: 200, height: 200)
                    .cornerRadius(100, corners: .all)
                    .padding(.bottom, 100)
                Text("Streak")
                    .font(.title3)
                    .foregroundColor(.secondaryWhite)
                    .bold()
                    .padding(.bottom, 20)
                ProfileMenuItemView(viewModel: ProfileMenuItemViewModel(title: "CURRENT", value: "0"))
                    .padding(.bottom, 16)
                ProfileMenuItemView(viewModel: ProfileMenuItemViewModel(title: "ALL TIME RECORD", value: "0"))
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

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(serviceManager: ServiceManager(),
                                                appCoordinator: AppCoordinator(serviceManager: ServiceManager())
                                               )
        )
    }
}
