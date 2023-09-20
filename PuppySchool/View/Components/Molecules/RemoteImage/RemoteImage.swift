//
//  RemoteImage.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var imageData: Data?
    @Published var isImageLoading = false
    @Published var loadingError: Error?

    var cancellables = Set<AnyCancellable>()

    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            print("Invalid URL.")
            return
        }

        isImageLoading = true

        URLSession.shared.dataTaskPublisher(for: imageURL)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.isImageLoading = false
                    self.loadingError = error
                    print("Error loading image: \(error.localizedDescription)")
                }
            } receiveValue: { data in
                self.isImageLoading = false
                self.imageData = data
            }
            .store(in: &cancellables)
    }
}

struct RemoteImage: View {
    let url: String
    @StateObject private var imageLoader = ImageLoader()

    var placeHolderImage: Icon
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat

    var body: some View {
        Group {
            if let imageData = imageLoader.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            } else if imageLoader.isImageLoading {
                ProgressView()
            } else {
                ZStack {
                    Circle()
                        .fill(Color.secondaryCharcoal)
                        .frame(width: width, height: height)
                    IconImage(placeHolderImage, width: 50, height: 50)
                }
            }
        }
        .onAppear(perform: {
            imageLoader.loadImage(from: url)
        })
    }
}

