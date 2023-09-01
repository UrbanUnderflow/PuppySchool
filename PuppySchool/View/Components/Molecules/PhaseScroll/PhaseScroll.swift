//
//  PhaseScroll.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import SwiftUI

class PhaseScrollViewModel: ObservableObject {
    @Published var userCommands: [UserCommand]
    @Published var commands: [Command]

    init(commands: [Command], userCommands: [UserCommand]) {
        self.userCommands = userCommands
        
        self.commands = commands.sorted { (command1, command2) -> Bool in
            let progress1 = userCommands.first(where: { $0.command.id == command1.id })?.calculateProgress() ?? 0
            let progress2 = userCommands.first(where: { $0.command.id == command2.id })?.calculateProgress() ?? 0

            return progress1 > progress2
        }
    }
}
struct PhaseScroll: View {
    @ObservedObject var viewModel: PhaseScrollViewModel
    var onCommandTap: (Command) -> Void

    func getUserCommand(for command: Command) -> UserCommand? {
        if command.name == "Sit" {
            print("here")
        }
        return viewModel.userCommands.first(where: { $0.command.id == command.id })
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.commands.sorted(by: { $0.priority < $1.priority }), id: \.self) { command in
                    CommandButtonView(command: command, userCommand: getUserCommand(for: command), action: onCommandTap)
                }
            }
        }
    }
}

struct CommandButtonView: View {
    var command: Command
    var userCommand: UserCommand?
    var action: (Command) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CommandCard(viewModel: CommandCardModel(
                commandIcon: command.icon,
                userCommand: userCommand
            ))
            Text(command.name)
                .font(.subheadline)
                .foregroundColor(.white)
                .bold()
        }
        .onTapGesture {
            action(command)
        }
    }
}



struct PhaseScroll_Previews: PreviewProvider {
    static var previews: some View {
        PhaseScroll(viewModel: PhaseScrollViewModel(commands: CommandService.sharedInstance.commands, userCommands: [Fixtures.shared.UserCommand])) { command in
            // This is just a dummy action for the preview.
            // In reality, when the app runs, this will be replaced by your actual implementation.
            print("Tapped on command: \(command.name)")
        }
    }
}

