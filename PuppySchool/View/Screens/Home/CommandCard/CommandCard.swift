//
//  CommandCard.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import SwiftUI

class CommandCardModel: ObservableObject {
    let commandIcon: DogCommandImages
    let userCommand: UserCommand?
    
    init(commandIcon: DogCommandImages, userCommand: UserCommand?) {
        self.commandIcon = commandIcon
        self.userCommand = userCommand
    }
}

struct CommandCard: View {
    @ObservedObject var viewModel: CommandCardModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(randomShadeColor())
                    .frame(width: 125, height: 125)
                IconImage(.commands(viewModel.commandIcon))
                    .frame(width: 65)
                VStack{
                    Spacer()
                    if let userCommand = viewModel.userCommand {
                        if userCommand.calculateProgress() != 0.0 {
                            ProgressBar(progress: viewModel.userCommand?.calculateProgress() ?? 0.0, color: .secondaryWhite)
                                .frame(width: 125, height: 10)
                        }
                    }
                }
            }
            .frame(width: 125, height: 125)
        }
        .cornerRadius(10)
    }
}

struct CommandCard_Previews: PreviewProvider {
    static var previews: some View {
        CommandCard(viewModel: CommandCardModel(commandIcon: .sit, userCommand: Fixtures.shared.UserCommand))
    }
}
