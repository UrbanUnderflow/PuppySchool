//
//  CommandDetailView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import SwiftUI
import AVFoundation


class CommandDetailViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    @Published var command: Command
    @Published var moduleStarted: Bool?
    @Published var userCommand: UserCommand
    @Published var clickCounter: Int = 0
    @Published var dogName: String
    @Published var sessionEnded: Bool = false
    
    init(appCoordinator: AppCoordinator, command: Command, userCommand: UserCommand?) {
        self.appCoordinator = appCoordinator
        self.command = command
        if let uCommand = userCommand {
            self.userCommand = uCommand
        } else {
            self.userCommand = UserCommand(id: UUID().uuidString, command: command, timesCompleted: 0, didMaster: false, createdAt: Date(), updatedAt: Date())
        }
        
        self.clickCounter = userCommand?.timesCompleted ?? 0
        self.dogName = UserService.sharedInstance.user?.dogName ?? ""
    }
    
    func clickClicker() {
        self.clickCounter = self.clickCounter + 1
        self.userCommand.timesCompleted = self.clickCounter
        
        CommandService.sharedInstance.updateUserCommandInArray(updatedUserCommand: self.userCommand)
        CommandService.sharedInstance.updateUserCommand(userCommand: self.userCommand)
    }
    
    func endSession() {
        CommandService.sharedInstance.updateUserCommand(userCommand: self.userCommand)
        sessionEnded = true
    }
    
    func startSession() {
        self.moduleStarted = true
    }
}

struct CommandDetailView: View {
    @ObservedObject var viewModel: CommandDetailViewModel
    
    
    func clickerSound() {
        SoundManager.sharedInstance.playClicker()
        viewModel.clickClicker()
    }
    
    var topGroup: some View {
        HStack {
            Spacer()
            VStack {
                if viewModel.moduleStarted ?? false {
                    Text("Click the button as your dog \nperforms the command.")
                        .font(.headline)
                        .foregroundColor(.secondaryWhite)
                        .multilineTextAlignment(.center)
                        .padding(.top, 90)
                    
                    VStack {
                        ZStack {
                            CircularProgressBarView(
                                progress: Double(viewModel.clickCounter),
                                maxProgress: Double(viewModel.command.completionMax),
                                colors: (
                                    start: Color(UIColor(red: 0.35, green: 0.38, blue: 1, alpha: 1)),
                                    end: Color(UIColor(red: 0.85, green: 0.34, blue: 1, alpha: 1))
                                )
                            )
                            .frame(width: 170, height: 170)
                            
                            Circle()
                                .fill(LinearGradient.primaryGradient)
                                .frame(width: 150, height: 150)
                            IconImage(.custom(.tap))
                                .frame(width: 80, height: 80)
                        }
                        .padding(.bottom, 20)
                        .onTapGesture {
                            clickerSound()
                        }
                        
                        Text("\(viewModel.dogName.capitalized) has performed \n\(viewModel.command.name) \(viewModel.clickCounter) out of \(viewModel.command.completionMax) times")
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondaryWhite)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 50)
                } else {
                    HStack(alignment: .top) {
                        Spacer()
                        IconImage(.commands(viewModel.command.icon))
                            .frame(width: 120)
                            .padding(.leading, 50)
                        VStack(alignment: .leading) {
                            Text(viewModel.command.name)
                                .font(.title3)
                                .foregroundColor(.secondaryWhite)
                                .bold()
                            Text(viewModel.command.description)
                                .font(.subheadline)
                                .foregroundColor(.secondaryWhite)
                            
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                    }
                    .padding(.top, 150)
                    .padding(.bottom, 100)
                }
            }
            Spacer()
        }
        .background(Color.primaryPurple.ignoresSafeArea(.all))
    }
    
    func stepRow(_ index: Int, isNotLastStep: Bool) -> some View {
        HStack(alignment: .top) {
            Text("0\(index + 1)")
                .foregroundColor(Color.secondaryWhite)
                .padding(.trailing, 10)
                .frame(width: 50)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(Color.secondaryWhite)
                        .frame(width: 40, height:40)
                    IconImage(.custom(.graidentPaw))
                        .frame(width: 24, height:24)
                }
                if isNotLastStep {
                    DottedLineView(color: Color.secondaryWhite, dashes: 5)
                        .frame(width: 2, height: .infinity)
                        .opacity(0.5)
                }
            }
            .padding(.trailing, 10)
            
            // Step Text
            Text("\(viewModel.command.steps[index])")
                .font(.body)
                .foregroundColor(.secondaryWhite)
                .frame(minHeight: 40)
                .layoutPriority(1)
            Spacer()
        }
    }
    
    var bottomGroup: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text("Steps")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.secondaryWhite)
                Spacer()
                Text("\(viewModel.command.steps.count) steps")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.secondaryWhite)
            }
            .padding(.bottom, 20)
            
            ForEach(viewModel.command.steps.indices, id: \.self) { index in
                HStack(alignment: .top) {
                    // Image and Line
                    VStack(spacing: 0) {
                        if index != 0 {
                            HStack {
                                DottedLineView(color: Color.secondaryWhite, dashes: 5)
                                    .frame(width: 2, height: 20)
                                    .opacity(0.5)
                                    .padding(.leading, 77)
                                Spacer()
                            }
                        }
                        HStack {
                            stepRow(index, isNotLastStep: index != viewModel.command.steps.count - 1)
                        }
                        if index != viewModel.command.steps.count - 1 {
                            HStack {
                                DottedLineView(color: Color.secondaryWhite, dashes: 5)
                                    .frame(width: 2, height: 20)
                                    .opacity(0.5)
                                    .padding(.leading, 77)
                                Spacer()
                            }
                        }
                    }
                    .padding(.trailing, 20)
                    
                    
                    
                    Spacer()
                }
            }
            if viewModel.moduleStarted == false {
                Text("If these steps are clear to you, start your training session.")
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
            }
        }
        .background(Color.secondaryPink)
    }
    
    var summaryView: some View {
        CommandSummaryView(viewModel: CommandSummaryViewModel(
            progress: CGFloat(Double(viewModel.userCommand.timesCompleted) / Double(viewModel.command.completionMax)),
            commandsLeft: viewModel.command.completionMax - viewModel.userCommand.timesCompleted,
            command: viewModel.command)) {
                self.viewModel.appCoordinator.closeModals()
            }
    }
    
    var body: some View {
        ZStack {
            if viewModel.sessionEnded {
                //Summary at the end of a session
                summaryView
            } else {
                ZStack {
                    ScrollView {
                        VStack {
                            ZStack {
                                topGroup
                                    .offset(y: -40)
                                if viewModel.userCommand.timesCompleted >= viewModel.userCommand.command.completionMax {
                                    LottieView(animationName: "party")
                                        .onAppear {
                                            SoundManager.sharedInstance.playCheering()
                                        }
                                }
                            }
                            bottomGroup
                                .offset(y: -20)
                                .padding(.horizontal)
                        }
                        Spacer()
                            .frame(height: 100)
                    }
                    .padding(.top, 30)
                    
                    VStack {
                        HStack {
                            CloseButtonView(action: {
                                viewModel.appCoordinator.closeModals()
                            })
                            .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 40)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        ConfirmationButton(title: viewModel.moduleStarted == true ? "End Session" : "Start" , type: .primaryLargeConfirmation) {
                            if viewModel.moduleStarted ?? false {
                                viewModel.endSession()
                            } else {
                                viewModel.startSession()
                            }
                        }
                        .padding(.bottom, 30)
                        .padding(.horizontal)
                    }
                }
                .background(Color.secondaryPink)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct CommandDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommandDetailView(viewModel: CommandDetailViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()),
                                                            command: Fixtures.shared.Sit, userCommand: Fixtures.shared.UserCommand))
    }
}
