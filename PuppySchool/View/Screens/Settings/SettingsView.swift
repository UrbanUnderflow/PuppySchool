import SwiftUI

class SettingsViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
        
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State var showMailView = false

    private var headerView: some View {
        HStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.secondaryWhite)
            Spacer()
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.primaryPurple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                Spacer()
                    .frame(height: 50)
                VStack(alignment: .leading, spacing: 10) {
                    headerView
                        .padding()
//                    SettingCard(title: "Account Settings")
//                    SettingCard(title: "Notification Settings")
//                    SettingCard(title: "Privacy Settings")
//                    SettingCard(title: "Language")
                    SettingCard(title: "Subscription Plan")
                        .onTapGesture {
                            viewModel.appCoordinator.showPayWallModal()
                        }
                    SettingCard(title: "Privacy Policy")
                        .onTapGesture {
                            //viewModel.appCoordinator.showPrivacyScreenModal()
                        }
                    SettingCard(title: "Terms and Conditions")
                        .onTapGesture {
                           // viewModel.appCoordinator.showTermsScreenModal()
                        }
//                    SettingCard(title: "Help & Support")
//                        .onTapGesture {
//                            showMailView.toggle()
//                        }
//                        .sheet(isPresented: $showMailView) {
//                                        MailView(subject: "Support from \(UserService.sharedInstance.user?.username ?? "User")", body: "", recipients: ["quickliftsapp@gmail.com"], isPresented: self.$showMailView)
//                                    }
                    SettingCard(title: "About")
                        .onTapGesture {
                            //viewModel.appCoordinator.showAboutScreenModal()
                        }
                    SettingCard(title: "Delete Account")
                        .onTapGesture {
                            viewModel.appCoordinator.showNotificationModal(viewModel: CustomModalViewModel(type: .field, title: "Delete Account", message: "Are you sure you want to delete your account?", primaryButtonTitle: "Yes, delete my account", secondaryButtonTitle: "Cancel", fieldSubtitle: "Enter your password to confirm deletion.", primaryAction: { message in
                                viewModel.appCoordinator.serviceManager.userService.deleteAccount(email: UserService.sharedInstance.user?.email ?? "", password: message) { result in
                                    switch result {
                                    case .success(_):
                                        self.viewModel.appCoordinator.handleLogout()
                                    case .failure(_):
                                        self.viewModel.appCoordinator.showToast(viewModel: ToastViewModel(message: "There was an issue deleting your account. Please contact admin", backgroundColor: .red, textColor: .white))
                                    }
                                }
                            }, secondaryAction: {
                                viewModel.appCoordinator.hideNotification()
                            }))
                        }
                    SettingCard(title: "Log out")
                        .onTapGesture {
                            viewModel.appCoordinator.handleLogout()
                        }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SettingCard: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondaryWhite)
                .padding()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondaryWhite)
                .padding()
        }
        .background(Color.secondaryCharcoal)
        .cornerRadius(10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
