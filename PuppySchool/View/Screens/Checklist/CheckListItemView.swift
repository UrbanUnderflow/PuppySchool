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
            VStack(spacing: 0) {
                HStack {
                    Text(viewModel.checkListItem.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.secondaryWhite)
                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
                HStack {
                    VStack {
                        RemoteImage(url: viewModel.checkListItem.imageUrl, placeHolderImage: .customIcon(.dog, color: .secondaryCharcoal), width: 115, height: 115, cornerRadius: 57)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.bottom, 8)
                        
                        ConfirmationButton(title: "Purchase", type: .primaryLargeGradientConfirmation) {
                            if let url = URL(string: viewModel.checkListItem.productURL) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.checkListItem.description)
                            .foregroundColor(Color.secondaryWhite)
                    }
                    .padding(.trailing, 20)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Why is this item important:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.secondaryWhite)
                    .padding(.leading, 20)
                ForEach(viewModel.checkListItem.whyItsImportant, id: \.self) { item in
                    HStack {
                        IconImage(.sfSymbol(.pawPrint, color: .secondaryPink), width: 14, height: 14)
                        Text(item)
                            .foregroundColor(Color.secondaryWhite)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    
                }
            }
            .padding(.vertical, 20)
            Rectangle()
                .fill(Color.gray)
                .opacity(0.2)
                .frame(height: 1)
                .padding(.horizontal, 20)
        }
        .background(Color.primaryPurple)
    }
}

struct CheckListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListItemView(viewModel:
                            CheckListItemViewModel(
                                checkListItem:
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
                            ))
    }
}
