//
//  DropDownFilter.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/25/23.
//

import SwiftUI

enum FilterByType: CaseIterable {
    case category, difficulty, environment, stage
}

class DropDownFilterViewModel: ObservableObject {
    var filterBy: FilterByType
    
    init(filterBy: FilterByType) {
        self.filterBy = filterBy
    }
    
    func getTitleForFilterType(_ filterType: FilterByType) -> String {
        switch filterType {
        case .category:
            return "Category"
        case .difficulty:
            return "Difficulty"
        case .environment:
            return "Environment"
        case .stage:
            return "Dog Stage"
        }
    }
}

struct DropDownFilterView: View {
    @ObservedObject var viewModel: DropDownFilterViewModel

    var body: some View {
        // Dropdown Picker
        HStack {
            Spacer() // Center the menu
            Menu {
                ForEach(FilterByType.allCases, id: \.self) { filterType in
                    Button(action: {
                        viewModel.filterBy = filterType
                    }) {
                        Text(viewModel.getTitleForFilterType(filterType))
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color.ash) // Choose your preferred color
                        .frame(width: 200, height: 60)
                    HStack {
                        // You might not have the IconImage function, you can replace it with your own icon
                        Image(systemName: "arrowtriangle.down.fill") // SF Symbols down arrow icon
                            .foregroundColor(.secondaryWhite)
                        Text(viewModel.getTitleForFilterType(viewModel.filterBy))
                            .foregroundColor(.secondaryWhite)
                            .font(.title3)
                            .bold()
                    }
                }
            }.id(viewModel.filterBy)

            Spacer()
        }
        .padding(.bottom, 20)
    }
}

struct DropDownFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownFilterView(viewModel: DropDownFilterViewModel(filterBy: .category))
    }
}
