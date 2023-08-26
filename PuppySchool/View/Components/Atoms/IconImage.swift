//
//  IconImage.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Foundation
import SwiftUI

struct IconImage: View {
    let icon: Icon
    let width: CGFloat?
    let height: CGFloat?
    let gradient: LinearGradient?

    init(_ icon: Icon, width: CGFloat? = 20, height: CGFloat? = 20, gradient: LinearGradient? = nil) {
        self.icon = icon
        self.width = width
        self.height = height
        self.gradient = gradient
    }

    var body: some View {
        Group {
            switch icon {
            case .sfSymbol(let sfSymbol, let color):
                if let gradient = gradient {
                    Image(systemName: sfSymbol.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .overlay(gradient.mask(Image(systemName: sfSymbol.rawValue).resizable().scaledToFit()))
                } else {
                    Image(systemName: sfSymbol.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .foregroundColor(color)
                }
            case .custom(let customImageName):
                Image(customImageName.rawValue)
                    .resizable()
                    .scaledToFit()
                
            case .customIcon(let customIconName, let color):
                Image(customIconName.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .foregroundColor(color)
                
            case .commands(let dogCommandImage):
                Image(dogCommandImage.rawValue)
                    .resizable()
                    .scaledToFit()
                
            case .commandIcon(let dogCommandIcon, let color):
                Image(dogCommandIcon.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .foregroundColor(color)
            case .logs(let logIcon, let color):
                Image(logIcon.rawValue)
                    .imageScale(.large)
                    .frame(width: width, height: height)
                    .foregroundColor(color)
                
            case .dogStage(let stageIcon, let color):
                Image(stageIcon.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .foregroundColor(color)
            case .messageImage(let messageImage):
                Image(messageImage.rawValue)
                    .resizable()
                    .scaledToFit()
                
            }
        }
    }
}
