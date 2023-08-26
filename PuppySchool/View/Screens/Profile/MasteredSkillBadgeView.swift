//
//  MasteredSkillBadgeView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/21/23.
//

import SwiftUI

class MasteredSkillBadgeViewModel: ObservableObject {
    @Published var badge: MasteredBadge
    @Published var isMastered: Bool
    
    init(badge: MasteredBadge, isMastered: Bool) {
        self.badge = badge
        self.isMastered = isMastered
    }
}

struct MasteredSkillBadgeView: View {
    @ObservedObject var viewModel: MasteredSkillBadgeViewModel

    var body: some View {
        ZStack {
            if viewModel.isMastered == true {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 100, height: 100)
                    IconImage(.commands(viewModel.badge.icon))
                        .frame(width: 60, height: 60)
                }
            } else {
                ZStack {
                    Circle()
                        .fill(Color.darkPurple)
                        .frame(width: 100, height: 100)
                    if let commandIcon = DogCommandIcon(rawValue: "\(viewModel.badge.icon.rawValue).SFSymbol") {
                        IconImage(.commandIcon(commandIcon, color: .primaryPurple), width: 60, height: 60)
                    }
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 70)
            .stroke(viewModel.isMastered ? Color.gray : Color.clear, lineWidth: 1))
    }
}


struct MasteredSkillBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MasteredSkillBadgeView(viewModel: MasteredSkillBadgeViewModel(badge: MasteredBadge(id: UUID().uuidString, icon: .sit), isMastered: true))
            MasteredSkillBadgeView(viewModel: MasteredSkillBadgeViewModel(badge: MasteredBadge(id: UUID().uuidString, icon: .sit), isMastered: false))
        }
    }
}
