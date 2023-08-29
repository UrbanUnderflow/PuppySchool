//
//  ErrorScreenView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/29/23.
//

import SwiftUI

enum ErrorCode: String {
    case purchase = "3303"
}

class ErrorScreenViewModel: ObservableObject {
    @Published var errorCode: ErrorCode
    
    init(errorCode: ErrorCode) {
        self.errorCode = errorCode
    }

}

struct ErrorScreenView: View {
	@ObservedObject var viewModel: ErrorScreenViewModel

    var body: some View {
        ZStack {
            Color.primaryPurple.ignoresSafeArea(.all)

            VStack {
                Spacer()
                IconImage(.commands(.playDead))
                    .frame(width: 220, height: 220)
                Text("Something went wrong? Try restarting the app. If the problem persists, get support at puppyschool.app")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                Text("Error Code: \(viewModel.errorCode.rawValue)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                Spacer()
            }
        }
    }
}

struct ErrorScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorScreenView(viewModel: ErrorScreenViewModel(errorCode: .purchase))
    }
}
