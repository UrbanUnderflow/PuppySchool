//
//  CheckListItem.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import SwiftUI

class CheckListItemViewModel: ObservableObject {
    @Published var checkListItem: CheckListItem
    
    init(checkListItem: CheckListItem) {
        self.checkListItem = checkListItem
    }
    
    func viewItem() {
        
    }
}

struct CheckListItemView: View {
    @ObservedObject var viewModel: CheckListItemViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.checkListItem.title)
                    .font(.title2)
                    .bold()
                Spacer()
                ConfirmationButton(title: "Purchase", type: .secondarySmallConfirmation) {
                    if let url = URL(string: viewModel.checkListItem.productURL) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            .padding()
            HStack {
                VStack {
                    RemoteImage(url: viewModel.checkListItem.imageUrl)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .padding(.vertical)
                Text(viewModel.checkListItem.description)
            }
            VStack(alignment: .leading) {
                Text("Why is this item important:")
                    .font(.headline)
                    .bold()
                    .padding()
                Text(viewModel.checkListItem.whyItsImportant)
                    .padding()
            }
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .frame(height: 1)
                .padding(.horizontal, 20)
        }
        
    }
}

struct CheckListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListItemView(viewModel:
                            CheckListItemViewModel(
                                checkListItem:
                                    CheckListItem(
                                        id: "Crate",
                                        title: "Dog Crate",
                                        imageUrl: "https://m.media-amazon.com/images/I/51n51fAoyPL._SL250_.jpg",
                                        productURL: "https://amzn.to/3OLxwsk",
                                        description: "A crate is a secure space for your puppy, resembling a den environment. It aids in housebreaking and ensures safety when you can't supervise directly.",
                                        whyItsImportant: """
                                        - Safety First: Keeps puppy safe from household hazards when unsupervised.
                                        - Housebreaking: Puppies usually avoid soiling their sleeping quarters; helps in potty training.
                                        - Comfort Zone: Provides a personal space where the puppy can relax and sleep.
                                        - Travel: Safest way to transport your puppy in a car.
                                        - Avoid Destruction: Prevents puppy from destructive behaviors when alone.
                                        - Routine and Discipline: Instills a sense of routine and discipline in your puppy's life.
                                        """,
                                        createdAt: Date(),
                                        updatedAt: Date()
                                    )
                            ))
    }
}
