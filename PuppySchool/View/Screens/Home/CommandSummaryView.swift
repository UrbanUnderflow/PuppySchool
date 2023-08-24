//
//  CommandSummary.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import SwiftUI

class CommandSummaryViewModel: ObservableObject {
    @Published var progress: CGFloat
    @Published var commandsLeft: Int
    @Published var command: Command
    
    init(progress: CGFloat, commandsLeft: Int, command: Command) {
        self.progress = progress
        self.commandsLeft = commandsLeft
        self.command = command
    }
}

struct CommandSummaryView: View {
    @ObservedObject var viewModel: CommandSummaryViewModel
    var onDone: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text("Good Job")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.secondaryWhite)
            Spacer()
                .frame(height: 50)
            LottieView(animationName: "dog", loopMode: .loop)
                .frame(width: 150, height: 150)
                .padding()
            
            Text("Hendrix is on his way to mastery. He has \(viewModel.commandsLeft) \(viewModel.command.name) commands left")
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            ProgressBar(progress: viewModel.progress, color: .primaryPurple)
                .frame(height: 8)
                .padding(.horizontal, 20)
            Spacer()
            ConfirmationButton(title: "Continue", type: .primaryLargeConfirmation) {
                self.onDone()
            }
            .padding()
        }
        .background(Color.teal, ignoresSafeAreaEdges: .all)
    }
}

struct CommandSummary_Previews: PreviewProvider {
    static var previews: some View {
        CommandSummaryView(viewModel: CommandSummaryViewModel(progress: 0.5, commandsLeft: 10, command: Fixtures.shared.Sit), onDone: {
            print("done")
        })
    }
}
