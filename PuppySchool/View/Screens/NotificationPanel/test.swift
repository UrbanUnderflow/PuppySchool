//
//  test.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/27/23.
//

import SwiftUI

class testModel: ObservableObject {
	let appCoordinator: AppCoordinator

	init(appCoordinator: AppCoordinator) {
		self.appCoordinator = appCoordinator
	}

}

struct test: View {
	@ObservedObject var viewModel: testModel

    var body: some View {
      VStack {
          IconImage(.messageImage(.handling))
      }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
	test(viewModel: testModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
