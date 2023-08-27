//
//  RemoteImage.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Foundation
import SwiftUI
import Combine

struct RemoteImage: View {
    let url: String
    @State private var imageData: Data? = nil
    @State private var isImageLoading = false
    @State private var loadingError: Error? = nil
        
    @State var placeHolderImage: Icon

    @State var width: CGFloat
    @State var height: CGFloat
    @State var cornerRadius: CGFloat
    
    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius, corners: .all)
            } else if isImageLoading {
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
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let imageURL = URL(string: url) else {
            print("Invalid URL.")
            return
        }

        isImageLoading = true

        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            DispatchQueue.main.async {
                self.isImageLoading = false
                if let error = error {
                    self.loadingError = error
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                self.imageData = data
            }
        }
        task.resume()
    }
}
