//
//  LogView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import SwiftUI

class LogViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager
    @Published var sortedLogs: [(date: Date, logs:[PuppyLog])]
    @Published var filteredLogs: [PuppyLog]

    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager, logs: [PuppyLog], filteredLogs:[PuppyLog]) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
        self.sortedLogs = logs.sortedAndGroupedByDate()
        self.filteredLogs = filteredLogs
    }
}

struct LogView: View {
    @ObservedObject var viewModel: LogViewModel
    @State private var refreshToggle: Bool = false

    func dateTitle(for group: (date: Date, logs:[PuppyLog])) -> some View {
        HStack {
            Circle()
                .fill(Color.secondaryPink)
                .frame(width: 12, height: 12)
            Text(group.date.monthDayFormat)
                .bold()
                .foregroundColor(.secondaryWhite)
            Spacer()
        }
        .padding(.leading, 15)
    }
    
    var filteredLogs: some View {
        ScrollView {
            Spacer()
                .frame(height: 26)
            Text(viewModel.filteredLogs.first?.createdAt.monthDayFormat ?? Date().monthDayFormat)
                .foregroundColor(.secondaryWhite)
                .font(.title3)
                .bold()
            VStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.filteredLogs, id: \.id) { log in
                    FilteredLogItem(viewModel: FilteredLogItemViewModel(icon: .logs(LogIcon(rawValue: log.type.rawValue) ?? .training, color: .secondaryWhite), text: log.text, time: log.createdAt.timeFormat))
                }
            }
            Spacer()
                .frame(height: 100)
        }
    }
    
    var unfilteredLogs: some View {
        ScrollView {
            Spacer()
                .frame(height: 26)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.sortedLogs, id: \.date) { group in
                    dateTitle(for: group)
                    DottedLineView(color: Color.gray, dashes: 10)
                        .frame(width: 1, height:20)
                        .opacity(0.5)
                        .padding(.leading, 20)
                    ForEach(group.logs, id: \.id) { log in
                        LogItem(
                            viewModel: LogItemViewModel(icon: .logs(LogIcon(rawValue: log.type.rawValue) ?? .training, color: .secondaryWhite),
                                text: log.text,
                                time: log.createdAt.timeFormat))
                    }
                    
                    if group.date != viewModel.sortedLogs.last?.date {
                        DottedLineView(color: Color.gray, dashes: 10)
                            .frame(width: 1, height:40)
                            .opacity(0.5)
                            .padding(.leading, 20)
                    }
                }
            }
            Spacer()
                .frame(height: 100)
        }
    }
    
    var emptyState: some View {
        VStack {
            Spacer()
                .frame(height: 80)
            LottieView(animationName: "dog", loopMode: .loop)
                .frame(width: 150, height: 150)
            Text("You dont have any \nlogs yet today")
                .bold()
                .font(.headline)
                .foregroundColor(Color.secondaryWhite)
                .multilineTextAlignment(.center)
            ConfirmationButton(title: "Add a log", type: .secondaryMediumConfirmation) {
                viewModel.appCoordinator.showLogAnEventModal()
            }
            Spacer()
        }
    }
    
    var body: some View  {
        ZStack {
            VStack {
                HeaderView(viewModel: HeaderViewModel(headerTitle: "Puppy Logs",
                                                      theme: .dark, type: .none,
                                                      actionIcon: viewModel.filteredLogs.count == 0 ? .custom(.calendar) : .sfSymbol(.minusCalendar, color: .white),
                closeModal: {
                    //nothing
                },
                actionCallBack: {
                    if viewModel.filteredLogs.count == 0 {
                        viewModel.appCoordinator.showCalendarModal(viewModel: CalendarViewModel(appCoordinator: viewModel.appCoordinator, puppyLogs: LogService.sharedInstance.puppyLogs))
                    } else {
                        viewModel.filteredLogs = [PuppyLog]()
                    }
                }))

                HStack {
                    Rectangle()
                        .fill(Color.secondaryWhite)
                        .opacity(0.5)
                        .frame(height: 1)
                }
                VStack {
                    if viewModel.sortedLogs.count == 0 {
                        emptyState
                    } else if viewModel.filteredLogs.count != 0 {
                        filteredLogs
                    } else {
                        unfilteredLogs
                    }
                }
            }
            
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.secondaryPink)
                            .frame(width: 60, height: 60)
                        IconImage(.sfSymbol(.plus, color: .secondaryWhite))
                    }
                    .padding(.trailing, 20)
                    .onTapGesture {
                        viewModel.appCoordinator.showLogAnEventModal()
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .background(Color.primaryPurple, ignoresSafeAreaEdges: .all)
        
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(viewModel: LogViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager(), logs: [
            PuppyLog(id: "Walk", text: "Went for a walk", type: .walk, createdAt: Date(), updatedAt: Date()),
            PuppyLog(id: "Poop", text: "Took a poop", type: .poop, createdAt: Date(), updatedAt: Date()),
            PuppyLog(id: "Water", text: "Drank some water", type: .water, createdAt: Date(), updatedAt: Date()),
            PuppyLog(id: "Ate", text: "Ate one of the meals for the day", type: .ate, createdAt: Date(), updatedAt: Date()),
            PuppyLog(id: "training", text: "Practiced some training", type: .training, createdAt: Date(), updatedAt: Date()),
        ], filteredLogs: []))
    }
}
