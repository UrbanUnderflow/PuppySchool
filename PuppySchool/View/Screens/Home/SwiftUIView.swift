//
//  SwiftUIView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/25/23.
//

import SwiftUI

class SwiftUIViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

}

struct SwiftUIView: View {
    @ObservedObject var viewModel: SwiftUIViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(viewModel: SwiftUIViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
