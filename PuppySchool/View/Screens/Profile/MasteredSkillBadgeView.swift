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
                IconImage(.commands(viewModel.badge.icon))
                    .frame(width: 30, height: 30)
                    .padding(20)
            } else {
                IconImage(.commands(viewModel.badge.icon))
                    .opacity(0.5)
                    .frame(width: 30, height: 30)
                    .padding(20)
            }
        }
        .background(RoundedRectangle(cornerRadius: 70)
            .stroke(viewModel.isMastered ? Color.gray : Color.blueGray, lineWidth: 1))
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
