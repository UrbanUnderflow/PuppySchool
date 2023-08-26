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
    @State private var isMastered = false

    var body: some View {
        VStack {
            Spacer()
            Text(isMastered ? "Hendrix has mastered the sit command!" : "Good Job")
                .font(.largeTitle)
                .bold()
                .foregroundColor(isMastered ? .primaryPurple : .secondaryWhite)
            Spacer()
                .frame(height: 50)
            
            if isMastered {
                ZStack {
                    Rectangle()
                        .fill(.teal)
                        .frame(height: 10)
                    Circle()
                        .fill(.teal)
                        .frame(width: 200, height: 200)
                    LottieView(animationName: "walking", loopMode: .loop)
                        .frame(width: 150, height: 150)
                        .padding()
                }
                .padding(.bottom, 20)
            } else {
                LottieView(animationName: "dog", loopMode: .loop)
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            Text(isMastered ? "Continue to train to keep \(UserService.sharedInstance.user?.dogName ?? "Hendrix" ) stimulated and playful" : "Hendrix is on his way to mastery. He has \(viewModel.commandsLeft) \(viewModel.command.name) commands left")
                .font(.subheadline)
                .bold()
                .foregroundColor(isMastered ? .primaryPurple : .white)
                .multilineTextAlignment(.center)
            if !isMastered {
                ProgressBar(progress: viewModel.progress, color: .primaryPurple)
                    .frame(height: 8)
                    .padding(.horizontal, 20)
            }
            Spacer()
            ConfirmationButton(title: "Continue", type: .primaryLargeConfirmation) {
                self.onDone()
            }
            .padding()
        }
        .background(isMastered ? Color.yellow : Color.teal, ignoresSafeAreaEdges: .all)
        .onAppear {
            isMastered = viewModel.progress == 1
            
            if isMastered {
                SoundManager.sharedInstance.playClapping()
            }
        }
    }
}

struct CommandSummary_Previews: PreviewProvider {
    static var previews: some View {
        CommandSummaryView(viewModel: CommandSummaryViewModel(progress: 0.5, commandsLeft: 10, command: Fixtures.shared.Sit), onDone: {
            print("done")
        })
    }
}
