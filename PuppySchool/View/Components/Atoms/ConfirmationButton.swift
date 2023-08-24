//
//  ConfirmationButton.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI

enum ButtonType {
    case primaryPurple
    case secondaryCharcoal
    case secondaryBlue
    case primaryLargeConfirmation
    case secondaryLargeConfirmation
    case secondaryMediumConfirmation
    case secondarySmallConfirmation
    case borderedButton
    case clearButton
    case whiteClearButton
    case shadowButton
    case chipButton
    case animatedCircleButton(icon: Icon)
    case backButton
    case loading
}

struct ConfirmationButton: View {
    var title: String
    var type: ButtonType
    var foregroundColor: Color? = .secondaryWhite
    var backgroundColor: Color? = .clear
    var backgroundOpacity: Double? = 0.2
    @State var isLoading: Bool = false

    var action: () -> ()
    
    @State private var isExpanded: Bool = false


    var body: some View {
        switch type {
        case .primaryPurple:
            Button(action: action) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.ash)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryPurple)
                    .cornerRadius(50)
            }
        case .secondaryCharcoal:
            Button(action: action) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.primaryPurple)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondaryCharcoal)
                    .cornerRadius(50)
            }
        case .secondaryBlue:
            Button(action: action) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.ash)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryPurple)
                    .cornerRadius(50)
            }
        case .primaryLargeConfirmation:
            Button(action: action) {
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryPurple)
                    .cornerRadius(18)
            }
        case .secondaryLargeConfirmation:
            Button(action: action) {
                Text(title)
                    .font(.title2)
                    .foregroundColor(Color.secondaryWhite)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.secondaryCharcoal)
                    .cornerRadius(50)
            }
            
        case .secondaryMediumConfirmation:
            Button(action: action) {
                Text(title)
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .foregroundColor(Color.secondaryWhite)
                    .padding()
                    .background(Color.secondaryCharcoal)
                    .cornerRadius(20)
            }
        case .secondarySmallConfirmation:
            Button(action: action) {
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.secondaryWhite)
                    .padding(10)
                    .background(Color.secondaryCharcoal)
                    .cornerRadius(10)
            }
        case .borderedButton:
            Button(action: action) {
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.secondaryWhite)
                    .padding(20)
                    .padding(.horizontal, 20)
                    .background(Color.clear)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(Color.secondaryWhite, lineWidth: 4)
                    )
            }

        case .clearButton:
            Button(action: action) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(foregroundColor)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        case .whiteClearButton:
            Button(action: action) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color.secondaryWhite)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        case .shadowButton:
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(backgroundColor ?? .secondaryWhite)
                        .opacity(backgroundOpacity ?? 0.2)
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(foregroundColor)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            
        case .chipButton:
            Button(action: action) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.secondaryCharcoal)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 20)
                    .background(Color.secondaryWhite)
                    .cornerRadius(50)
            }
        case .animatedCircleButton(let icon):
            Button(action: {
                            if isExpanded {
                                // if button is already expanded, execute the action immediately
                                action()
                            } else {
                                // if button is not expanded, animate the expansion and wait for next tap
                                withAnimation(.spring()) {
                                    isExpanded = true
                                }
                                // set a timer to collapse the button if it's not tapped within 30 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
            }) {
                ZStack {
                    if !isExpanded {
                        IconImage(icon)
                            .frame(width: 56, height: 56)
                            .background(Color.secondaryWhite)
                            .cornerRadius(28)
                            .opacity(isExpanded ? 0 : 1)
                    }
                    
                    if isExpanded {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(Color.secondaryCharcoal)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 20)
                            .background(Color.secondaryWhite)
                            .cornerRadius(50)
                            .frame(minWidth: 56, maxWidth: .infinity)
                            .opacity(isExpanded ? 1 : 0)
                            .transition(.scale)
                            .onAppear {
                                // when the expanded button appears, cancel the previous timer and set a new one
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
                            .onDisappear {
                                // when the expanded button disappears (i.e., the action is executed), reset the timer
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
                    }
                }
            }
                                
        case .backButton:
            Button(action: action) {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.clear)
                        .frame(width: 46, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.secondaryWhite, lineWidth: 1)
                        )
                    IconImage(.custom(.miniChevLeft))
                        .frame(width: 24, height: 24)
                }
                .frame(width: 46, height: 46)
            }
        case .loading:
            ZStack {
                Circle()
                    .fill(Color.secondaryWhite)
                
                if isLoading {
                    // When loading, show the spinning loading icon
                    LottieView(animationName: "loading", loopMode: .loop)
                        .frame(width: 30, height: 30)
                        .padding()
                } else {
                    // When loading is finished, show the check icon
                    IconImage(.sfSymbol(.check, color: .green))
                        .scaledToFit()
                        .padding()
                        .frame(width: 40, height: 40)
                        .animation(.default)
                }
            }
            .frame(width: 60, height: 60)
            .onAppear {
                // Animate the button to a spinning loading state
                withAnimation(.default) {
                    self.isLoading = true
                }
                
                // When loading is complete, change the icon to a check and animate to green
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.default) {
                        self.isLoading = false
                    }
                    
                    // Add another delay of 1 second before animating back to the original state
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.default) {
                            self.isLoading = false
                        }
                    }
                }
            }
            .onDisappear {
                self.isLoading = false
            }

        }
    }
}

struct ConfirmationButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ConfirmationButton(title: "test", type: .secondaryBlue) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .clearButton) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .secondaryMediumConfirmation) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .secondarySmallConfirmation) {
                print("action 2")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmation) {
                print("action 2")
            }
            .padding()
            
            ConfirmationButton(title: "Bordered Button", type: .borderedButton) {
                print("bordered")
            }
            
            VStack {
                Text("How was the workout?")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.secondaryWhite)
                HStack {
                    ConfirmationButton(title: "Too Easy", type: .shadowButton) {
                        print("easy")
                    }
                    .frame(height: 50)

                    ConfirmationButton(title: "Too Hard", type: .shadowButton) {
                        print("easy")
                    }
                    ConfirmationButton(title: "Just Right", type: .shadowButton) {
                        print("easy")
                    }
                }
                ConfirmationButton(title: "test", type: .animatedCircleButton(icon: .sfSymbol(.upload, color: .secondaryCharcoal)), foregroundColor: .secondaryCharcoal) {
                    print("action 2")
                }
                ConfirmationButton(title: "test", type: .chipButton) {
                    print("action 2")
                }
                Spacer()
            }
            .background(Color.secondaryCharcoal)
        }
    }
}
