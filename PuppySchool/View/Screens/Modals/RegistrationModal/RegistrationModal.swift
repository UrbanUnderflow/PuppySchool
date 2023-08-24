//
//  RegistrationModal.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/22/23.
//

import SwiftUI

class RegistrationModalViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    @Published var selectedStage = DogStage.puppy
    @Published var selectedDogStageDescription: DogStageDescription? = DogStageDescription(
                                                                               id: UUID(),
                                                                               title: "Get ready for a life of dog parenthood!",
                                                                               stage: DogStage.puppy,
                                                                               icon: .puppyStage,
                                                                               description: "Puppy is highly receptive to new experiences, making it an ideal time for socialization and foundational training.",
                                                                            
                                                                               longDescription: """
                                                                               The puppy stage is a crucial period in a dog's life, brimming with rapid growth and boundless curiosity. It's akin to the toddler years in humans. Puppies at this age are like little sponges, eager to explore and absorb everything around them. This makes it the prime time to lay the foundation for a well-rounded adult dog. Their brain is incredibly plastic, and they're forming associations about the world that will stick with them for life. It's vital to ensure those associations are positive. Prioritize socialization, expose them gently to a myriad of environments, sounds, and experiences.\n\nRemember, this is not just about obedience training – it's about shaping their perception of the world. Be patient, consistent, and loving. Approach training with a blend of structure, fun, and plenty of rewards. Positive reinforcements at this stage not only instill good behavior but also build a trusting bond between you and your puppy.
                                                                               """,
                                                                               tips: [
                                                                                   DogStageTips(id: UUID(), title: "Socialization", description: "Expose your puppy to various sights, sounds, smells, people, animals, and environments. The goal is to ensure these experiences are positive to prevent future fears or aggressive behaviors."),
                                                                                   DogStageTips(id: UUID(), title: "Positive Reinforcement", description: "Always reward positive behavior with treats, praise, or toys. Positive reinforcement helps the puppy associate good behavior with rewards."),
                                                                                   DogStageTips(id: UUID(), title: "Basic Commands", description: "Start teaching simple commands like 'sit,' 'stay,' 'come,' 'down,' and 'leave it.' Use treats and praise as rewards."),
                                                                                   DogStageTips(id: UUID(), title: "Name Recognition", description: "Frequently call the puppy by its name, and reward it when it looks at you. This reinforces name recognition."),
                                                                                   DogStageTips(id: UUID(), title: "House Training", description: "Establish a regular feeding routine and take your puppy out first thing in the morning, after meals, before bed, and when it wakes from naps. Praise it when it does its business outside."),
                                                                                   DogStageTips(id: UUID(), title: "Bite Inhibition", description: "Puppies like to chew and nip. If your puppy bites too hard during play, let out a high-pitched 'ouch!' and stop playing momentarily. This teaches the puppy that gentle play continues, but rough play stops."),
                                                                                   DogStageTips(id: UUID(), title: "Handling", description: "Regularly handle your puppy's paws, ears, mouth, and body. This makes future grooming and vet visits easier."),
                                                                                   DogStageTips(id: UUID(), title: "Avoid Negative Experiences", description: "Traumatic events during this stage can have a lasting impact. Always supervise interactions with children and other animals."),
                                                                                   DogStageTips(id: UUID(), title: "Consistency", description: "Be consistent with rules and commands. If jumping is not allowed, ensure everyone in the household enforces this rule."),
                                                                                   DogStageTips(id: UUID(), title: "Crate Training", description: "Introduce your puppy to a crate as a safe haven. Start with short durations and increase gradually."),
                                                                                   DogStageTips(id: UUID(), title: "Avoid Overwhelming the Puppy", description: "While socialization is vital, avoid situations where your puppy might feel overwhelmed. Positive experiences are key."),
                                                                               ],
                                                                               ageRange: "3-14 weeks")
    @Published var puppyName = ""

    @Published var imageUrl = ""
        
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
}

struct RegistrationModal: View {
    @ObservedObject var viewModel: RegistrationModalViewModel
    @State private var selectedPage = 0
    @State var selectedImage: UIImage? = nil
    
    func nextButtonPressed() {
        guard let u = UserService.sharedInstance.user else {
            print("Something went wrong with getting the user during auth")
            return
        }
        
        var updatedUser = u
        
        if selectedPage == 0 {
            updatedUser.dogName = viewModel.puppyName.lowercased()
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage == 1 {
            updatedUser.dogStage = viewModel.selectedStage
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage == 2 {
            updatedUser.profileImageURL = viewModel.imageUrl
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        
        if selectedPage <= 3 {
            withAnimation {
                selectedPage += 1
            }
        }
        
        //once everything is selected we can create a workout for the user
        if selectedPage > 3 {
            viewModel.appCoordinator.closeModals()
        }
    }

    var titleGroup: some View {
        VStack {
            if selectedPage == 3 {
                HStack {
                    VStack(alignment: .leading, spacing: 9) {
                        Text(viewModel.selectedDogStageDescription?.title ?? "Prepare to me a new dog parent!")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 44))
                            .bold()
                        Text("Here's some information about your dog at this stage.")
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding(.leading, 20)
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("We have a few questions")
                            .multilineTextAlignment(.leading)
                            .font(.largeTitle)
                            .bold()
                        Text("Tell us about your dog.")
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(selectedPage + 1)/3")
                            .foregroundColor(Color.gray)
                            .font(.subheadline)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    ProgressView(value: Double(selectedPage + 1), total: 5)
                        .padding()
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.primaryPurple))
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            titleGroup
            
            ZStack {
                TabView(selection: $selectedPage) {
                    VStack(alignment: .leading) {
                        Text("What is your puppy's name?")
                            .bold()
                            .padding(.leading, 20)
                        
                        ZStack {
                            TextFieldWithIcon(text: $viewModel.puppyName, placeholder: "", icon: .dogStage(.puppyStage), isSecure: false)
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                        .padding()
                        Spacer()
                        
                    }
                    .tag(0)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Choose the age of your puppy.")
                                .bold()
                                .padding(.leading, 20)
                                .padding(.bottom, 12)
                            StageSelectionView(viewModel: StageSelectionViewModel(), onSubmittedAnswer: { selectedOption in
                                print("Selected option: \(selectedOption)")
                                viewModel.selectedStage = selectedOption.stage
                                viewModel.selectedDogStageDescription = selectedOption
                            })
                            Spacer()
                                .frame(height: 60)
                        }
                    }.tag(1)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Let's get your puppy's cutest photo!")
                                .bold()
                                .padding(.bottom, 12)
                            
                            HStack {
                                Spacer()
                                UploadImageView(viewModel: UploadImageViewModel(serviceManager: viewModel.appCoordinator.serviceManager, onImageUploaded: { image in
                                    self.selectedImage = image
                                })) {
                                    VStack(alignment: .center, spacing:20) {
                                        if let image = selectedImage {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(75, corners: .all)
                                        } else {
                                            VStack {
                                                IconImage(.sfSymbol(.camera, color: .gray), width: 36 , height: 36)
                                                
                                                Text("Upload a photo")
                                                    .foregroundColor(.gray)
                                                    .font(.title3)
                                                    .bold()
                                                    .padding(.bottom, 5)
                                            }
                                            .frame(height: 150)
                                        }
                                        
                                    }
                                }
                                Spacer()
                            }
                            .padding(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.blueGray,
                                        lineWidth: 2
                                    )
                            )
                            ConfirmationButton(title: "Skip", type: .clearButton) {
                                viewModel.appCoordinator.closeModals()
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                    }.tag(2)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                if let icon = viewModel.selectedDogStageDescription?.icon {
                                    IconImage(.dogStage(icon))
                                        .frame(width: 200, height: 200)
                                }
                                Spacer()
                            }
                            .padding()
                            
                            Text(viewModel.selectedDogStageDescription?.longDescription ?? "")
                                .padding(.bottom)
                            
                            Text("Tips for your dog at this stage")
                                .bold()
                                .font(.title3)
                                .padding(.bottom)
                            
                            if let tips = viewModel.selectedDogStageDescription?.tips {
                                ForEach(tips, id: \.self) { tip in
                                    VStack(alignment: .leading) {
                                        Text(tip.title)
                                            .bold()
                                            .padding(.bottom, 2)
                                        Text(tip.description)
                                            .padding(.bottom, 12)
                                    }
                                }
                            }

                         
                            ConfirmationButton(title: "Skip", type: .clearButton) {
                                viewModel.appCoordinator.closeModals()
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                    }.tag(3)
                }
                
                VStack {
                    Spacer()
                    ConfirmationButton(title: selectedPage == 3 ? "Complete" : "Next", type: .primaryLargeConfirmation) {
                        nextButtonPressed()
                    }
                    .padding()
                }
            }
        }
    }
}

struct RegistrationModal_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
