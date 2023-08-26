//
//  HeaderView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//

import SwiftUI

class HeaderViewModel: ObservableObject {
    enum HeaderType {
        case close
        case back
    }
    
    enum ThemeType {
        case light
        case dark
    }
    
    @Published var headerTitle: String
    @Published var theme: ThemeType
    @Published var type: HeaderType
    @Published var actionIcon: Icon?
    
    var closeModal: (() -> Void)
    var actionCallBack: () -> Void

    init(headerTitle: String, theme: ThemeType = .light, type: HeaderType = .close, actionIcon: Icon? = nil, closeModal: @escaping (() -> Void), actionCallBack: @escaping () -> Void) {
        self.headerTitle = headerTitle
        self.theme = theme
        self.type = type
        self.actionIcon = actionIcon
        self.closeModal = closeModal
        self.actionCallBack = actionCallBack
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel: HeaderViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                if viewModel.type == .back {
                    BackButton().onTapGesture {
                        viewModel.closeModal()
                    }
                    .padding(.leading, 20)
                } else {
                    CloseButtonView {
                        viewModel.closeModal()
                    }
                    .padding(.leading, 20)
                }

                Spacer()
                Text(viewModel.headerTitle)
                    .foregroundColor(viewModel.theme == .dark ? .secondaryWhite : .secondaryCharcoal)
                    .font(.headline)
                    .padding()
                Spacer()
                if (viewModel.actionIcon != nil) {
                    IconImage(viewModel.actionIcon!)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            viewModel.actionCallBack()
                        }
                } else {
                    Spacer()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 20)
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: HeaderViewModel(headerTitle: "Test", closeModal: {
            print("close")
        }, actionCallBack: {
            print("action")
        }))
    }
}

