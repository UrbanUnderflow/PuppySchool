//
//  ChecklistView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import SwiftUI

class CheckListViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager
    let checklistItems: [CheckListItem]
    
    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager, checklistItems: [CheckListItem]) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
        self.checklistItems = checklistItems
    }
}

struct CheckListView: View {
    @ObservedObject var viewModel: CheckListViewModel
    
    var body: some View  {
        VStack {
            HeaderView(viewModel: HeaderViewModel(headerTitle: "Doggy Essentials", theme: .dark, type:.none, actionIcon: nil, closeModal: {
                //close
            }, actionCallBack: {
                viewModel.appCoordinator.showLogAnEventModal()
            }))
            ScrollView {
                VStack {
                    ForEach(viewModel.checklistItems, id: \.id) { item in
                        CheckListItemView(viewModel: CheckListItemViewModel(checkListItem: item))
                    }
                }
                Spacer()
                    .frame(height: 100)
            }
        }
        .background(Color.primaryPurple)
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(viewModel: CheckListViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager(), checklistItems: [
            CheckListItem(
                id: "Crate",
                title: "Crate",
                imageUrl: "https://m.media-amazon.com/images/I/51n51fAoyPL._SL250_.jpg",
                productURL: "https://amzn.to/3OLxwsk",
                description: "A crate is a secure space for your puppy, resembling a den environment. It aids in housebreaking and ensures safety when you can't supervise directly.",
                whyItsImportant: [
                "Safety First: Keeps puppy safe from household hazards when unsupervised.",
                "Housebreaking: Puppies usually avoid soiling their sleeping quarters; helps in potty training.",
                "Comfort Zone: Provides a personal space where the puppy can relax and sleep.",
                "Travel: Safest way to transport your puppy in a car.",
                "Avoid Destruction: Prevents puppy from destructive behaviors when alone.",
                "Routine and Discipline: Instills a sense of routine and discipline in your puppy's life.",
                ],
                createdAt: Date(),
                updatedAt: Date()
            )
            ])
        )
    }
}
