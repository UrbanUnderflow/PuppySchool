//
//  AddLogModal.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import SwiftUI
class AddLogModalViewModel: ObservableObject {
    @Published var title: String

    @Published var selectedLogType: PuppyLogType? = nil
    @Published var showTimePicker: Bool = false
    @Published var selectedDate: Date = Date()
    
    @Published var timeValue: String = ""
    @Published var subtitle: String = ""
    
    var close: () -> Void
    var action: () -> Void
    
    init(title: String, subtitle: String, action: @escaping () -> Void, close: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        self.close = close
    }
    
    func logEvent() {
        LogService.sharedInstance.logEvent(log: LogService.sharedInstance.getLocalLog(byType: selectedLogType ?? .walk)) { puppyLog, error in
            if let log = puppyLog {
                LogService.sharedInstance.puppyLogs.append(log)
                FirebaseService.sharedInstance.logAddToLogEvent(event: log.type.rawValue)
                self.action()
            } else {
                self.subtitle = "There was an error logging your event. Try again."
                FirebaseService.sharedInstance.logAddToLogEventFailed(error: "\(self.selectedLogType?.rawValue ?? "unknown log type") failed with: \(error?.localizedDescription ?? "unknown error")")

            }
        }
    }
}

struct AddLogModal: View {
    @ObservedObject var viewModel: AddLogModalViewModel

    func createSelectionButton(type: PuppyLogType) -> some View {
        ZStack {
            Circle()
                .fill(viewModel.selectedLogType == type ? Color.secondaryPink : Color.secondaryWhite)
                .frame(width: 64, height: 64)
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            IconImage(.logs(LogIcon(rawValue: type.rawValue) ?? .walk, color: viewModel.selectedLogType == type ? Color.secondaryWhite : Color.primaryPurple))
                .frame(width:24, height: 24)
                .padding()
        }
        .onTapGesture {
            viewModel.selectedLogType = type
        }
    }
    
    var fieldText: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.lightGray)
                    .cornerRadius(20, corners: .all)
                    .padding(.horizontal, 30)
                
                if viewModel.showTimePicker {
                    VStack {
                        DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .onChange(of: viewModel.selectedDate) { _ in
                                // Update the textFieldValue when the date changes
                                let formatter = DateFormatter()
                                formatter.timeStyle = .short
                                viewModel.timeValue = formatter.string(from: viewModel.selectedDate)

                                // Force a UI update by toggling the showTimePicker after the value update
                                DispatchQueue.main.async {
                                    viewModel.showTimePicker = false
                                }
                            }

                    }
                } else {
                    HStack {
                        Text(viewModel.timeValue == "" ? "Current Time" : viewModel.timeValue)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .opacity(0.8)
                            .padding(.leading, 50)
                        Spacer()
                        IconImage(.sfSymbol(.clock, color: .secondaryCharcoal))
                            .padding(.trailing, 50)
                    }
                    .cornerRadius(20, corners: .all)
                }
            }
            .frame(height: viewModel.showTimePicker ? 200 : 65) // Increase height when the picker is visible
            .onTapGesture {
                viewModel.showTimePicker.toggle()
            }

            Text(viewModel.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondaryCharcoal)
                .bold()
        }
        .padding()
    }
    
    var body: some View {
        var selectedEvent: Icon? = nil
        
        return VStack {
            HStack {
                Text(viewModel.title)
                    .font(.title3)
                    .foregroundColor(.secondaryCharcoal)
                    .bold()
                    .padding(.leading, 24)
                    .padding(.top, 26)
                Spacer()
                IconImage(.sfSymbol(.close, color: .gray))
                    .foregroundColor(.secondaryCharcoal)
                    .onTapGesture {
                        viewModel.close()
                }
                .padding(.trailing, 24)
                .padding(.top, 26)
            }
            
            VStack {
                HStack {
                    createSelectionButton(type: .poop)
                    createSelectionButton(type: .ate)
                    createSelectionButton(type: .training)
                }

                HStack {
                    createSelectionButton(type: .water)
                    createSelectionButton(type: .walk)
                }
            }
            .padding(.vertical, 30)
            
            fieldText
               
            ConfirmationButton(title: "Log", type: .primaryLargeConfirmation) {
                viewModel.logEvent()
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 30)
            
        }
    }
}

struct AddLogModal_Previews: PreviewProvider {
    static var previews: some View {
        AddLogModal(viewModel: AddLogModalViewModel(title: "Choose an event", subtitle: "What time did you complete the event?", action: {
            print("add")
        }, close: {
            print("close")
        }))
    }
}
