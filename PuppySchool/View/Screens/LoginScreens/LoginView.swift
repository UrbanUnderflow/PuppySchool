//
//  LoginView.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import SwiftUI
import AuthenticationServices

class LoginViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var showPassword = false
    @Published var errorMessage: String?
    
    init(appCoordinator: AppCoordinator, isSignUp: Bool) {
        self.appCoordinator = appCoordinator
        self.isSignUp = isSignUp
    }
    
    func signUp(email: String, password: String) {
        self.appCoordinator.signUpUser(email: email, password: password) { result in
            switch result {
            case .success(let message):
                print(message)
                self.appCoordinator.serviceManager.userService.getUser { user, error in
                    //got user
                    print(user)
                }
                self.appCoordinator.showHomeScreen()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signIn(email: String, password: String) {
        self.appCoordinator.signIn(email: email, password: password) { result in
            switch result {
            case .success(let message):
                print(message)
                self.appCoordinator.handleLogin()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func startAppleSignIn() {
        self.appCoordinator.signInWithApple { result in
            switch result {
            case .success(let message):
                print(message)
                self.appCoordinator.handleLogin()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 8) {
                    Text(viewModel.isSignUp ? "Let's Sign You Up" : "Let's Sign You In")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    Text("Enter your \(viewModel.isSignUp ? "sign up" : "login") details")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 33)
               
                TextFieldWithIcon(text: $viewModel.email, placeholder: "Email address", icon: .sfSymbol(.message, color: .secondaryWhite), isSecure: false)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding(.horizontal, 20)
                Spacer()
                    .frame(height:20)
                TextFieldWithIcon(text: $viewModel.password, placeholder: "Password", icon: .sfSymbol(.lock, color: .secondaryWhite), isSecure: true)
                    .keyboardType(.default)
                    .textContentType(.password)
                    .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    Text("Forgot Password?")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                }
                
                if viewModel.isSignUp {
                    ConfirmationButton(title: "Sign Up", type: .secondaryLargeConfirmation) {
                        viewModel.signUp(email: viewModel.email, password: viewModel.password)

                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)

                    ConfirmationButton(title: "Sign up with Apple", type: .signInWithApple) {
                        viewModel.startAppleSignIn()
                    }
                    .padding(.horizontal, 16)
                } else {
                    ConfirmationButton(title: "Let's Sign You In", type: .secondaryLargeConfirmation) {
                        viewModel.signIn(email: viewModel.email, password: viewModel.password)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    ConfirmationButton(title: "Sign in with Apple", type: .signInWithApple) {
                        viewModel.startAppleSignIn()
                    }
                    .padding(.horizontal, 16)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(viewModel.isSignUp ? "Already have an account? Log in" : "Don't have an account? Sign up") {
                    viewModel.isSignUp.toggle()
                }
                .foregroundColor(.white)
                .padding(.top)
                
            }
        }
        .padding()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            LoginView(viewModel: LoginViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), isSignUp: true))
        }
    }
}

