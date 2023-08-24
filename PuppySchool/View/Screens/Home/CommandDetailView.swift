//
//  CommandDetailView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import SwiftUI

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

    var body: some View {
        ZStack {
            if viewModel.sessionEnded {
                CommandSummaryView(viewModel: CommandSummaryViewModel(
                    progress: CGFloat(Double(viewModel.userCommand.timesCompleted) / Double(viewModel.command.completionMax)),
                    commandsLeft: viewModel.command.completionMax - viewModel.userCommand.timesCompleted,
                    command: viewModel.command)) {
                        self.viewModel.appCoordinator.closeModals()
                }
            } else {
                ScrollView {
                    HStack {
                        Text(viewModel.command.name)
                            .font(.largeTitle)
                            .padding(.leading, 50)
                            .bold()
                        Spacer()
                    }
                    .padding(.top, 30)
                    VStack {
                        if viewModel.moduleStarted ?? false {
                            ZStack {
                                CircularProgressBarView(progress: Double(viewModel.clickCounter), maxProgress: Double(viewModel.command.completionMax), colors: (start: Color.blue, end: Color.gray))
                                    .frame(width: 170, height: 170)
                                Circle()
                                    .fill(.gray)
                                    .frame(width: 150, height: 150)
                                    .onTapGesture {
                                        viewModel.clickClicker()
                                    }
                            }
                            Text("\(viewModel.dogName) has performed \(viewModel.command.name) \(viewModel.clickCounter) out of \(viewModel.command.completionMax) times")
                        } else {
                            HStack {
                                IconImage(.commands(viewModel.command.icon))
                                    .frame(width: 120)
                                    .padding(.leading, 50)
                                Spacer()
                            }
                        }
                        
                        HStack(alignment: .center) {
                            Text("Steps")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(viewModel.command.steps.count) steps")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 50)
                        .padding(.trailing, 20)
                        .padding(.top, 50)
                        
                        ForEach(viewModel.command.steps.indices, id: \.self) { index in
                            HStack(alignment: .top) {
                                
                                // Step Number
                                Text("0\(index + 1)")
                                    .foregroundColor(Color.black)
                                    .padding(.trailing, 10)
                                    .frame(width: 50)
                                
                                // Image and Line
                                VStack {
                                    IconImage(.custom(.paw))
                                    if index != viewModel.command.steps.count - 1 {
                                        DottedLine()
                                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                            .frame(height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                .frame(width: 20)
                                .padding(.trailing, 20)
                                
                                // Step Text
                                Text("\(viewModel.command.steps[index])")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .frame(minHeight: 40)
                                    .layoutPriority(1)
                                
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            
                        }
                        if viewModel.moduleStarted == false {
                            Text("If these steps are clear to you, start your training session.")
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.top, 20)
                        }
                    }
                }
                .padding(.top, 30)
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
