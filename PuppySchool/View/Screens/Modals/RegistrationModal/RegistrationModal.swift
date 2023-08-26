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
    @Published var birthday: String = ""
    @Published var birthdate: Date = Date()
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
    @State private var isDatePickerShown = false
    
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
        
        if selectedPage == 2 {
            updatedUser.birthdate = viewModel.birthdate
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage <= 4 {
            withAnimation {
                selectedPage += 1
            }
        }
        
        //once everything is selected we can create a workout for the user
        if selectedPage > 4 {
            viewModel.appCoordinator.closeModals()
        }
    }

    var titleGroup: some View {
        VStack {
            if selectedPage == 4 {
                HStack {
                    VStack(alignment: .leading, spacing: 9) {
                        Text(viewModel.selectedDogStageDescription?.title ?? "Prepare to me a new dog parent!")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondaryWhite)
                            .font(.system(size: 44))
                            .bold()
                        Text("Here's some information about your dog at this stage.")
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundColor(.secondaryWhite)
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
                            .foregroundColor(.secondaryWhite)
                        Text("Tell us about your dog.")
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundColor(.secondaryWhite)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(selectedPage + 1)/4")
                            .foregroundColor(Color.secondaryWhite)
                            .font(.subheadline)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    ProgressView(value: Double(selectedPage + 1), total: 5)
                        .padding()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(UIColor(red: 0.35, green: 0.38, blue: 1, alpha: 1)),
                                    Color(UIColor(red: 0.85, green: 0.34, blue: 1, alpha: 1))
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                ProgressView(value: Double(selectedPage + 1), total: 5)
                                    .padding()
                            )
                        )
                }
            }
        }
    }
    
    var puppyName: some View {
        VStack(alignment: .leading) {
            Text("What is your puppy's name?")
                .bold()
                .padding(.leading, 20)
                .foregroundColor(.secondaryWhite)
            
            ZStack {
                TextFieldWithIcon(text: $viewModel.puppyName, placeholder: "", icon: .customIcon(.dog, color: Color.secondaryWhite), isSecure: false)
            }
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1))
            .padding()
            Spacer()
            
        }
    }
    
    var puppyAge: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Choose the age of your puppy.")
                    .bold()
                    .padding(.leading, 20)
                    .padding(.bottom, 12)
                    .foregroundColor(.secondaryWhite)
                StageSelectionView(viewModel: StageSelectionViewModel(), onSubmittedAnswer: { selectedOption in
                    print("Selected option: \(selectedOption)")
                    viewModel.selectedStage = selectedOption.stage
                    viewModel.selectedDogStageDescription = selectedOption
                })
                Spacer()
                    .frame(height: 60)
            }
        }
    }
    
    var puppyBirthday: some View {
        VStack(alignment: .leading) {
            Text("If you know your puppy's birthday, choose the date")
                .bold()
                .padding(.leading, 20)
                .foregroundColor(.secondaryWhite)

            ZStack {
                Color.darkPurple
                if !isDatePickerShown {
                   HStack {
                       IconImage(.sfSymbol(.birthday, color: .secondaryWhite))
                           .padding(.trailing, 10)
                      
                       Text(viewModel.birthday.isEmpty ? "Choose Date" : viewModel.birthday)
                           .foregroundColor(.secondaryWhite)
                       Spacer()
                   }
                   .onTapGesture {
                       isDatePickerShown.toggle()
                   }
                   .padding()
               }
                
                if isDatePickerShown {
                    VStack {
                        DatePicker("", selection: $viewModel.birthdate, displayedComponents: .date)
                            .background(Color.white)
                            .datePickerStyle(WheelDatePickerStyle())
                            .onDisappear {
                                viewModel.birthday = viewModel.birthdate.dayMonthYearFormat
                            }
                            .padding(.top, 100)
                        
                        Button {
                            isDatePickerShown.toggle()
                            viewModel.birthday = viewModel.birthdate.dayMonthYearFormat
                        } label: {
                            Text("Done")
                                .foregroundColor(.secondaryWhite)
                                .padding(.vertical)
                        }
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondaryWhite, lineWidth: isDatePickerShown ? 0 : 1)
            )
            .frame(height: 30)
            .padding()
            Spacer()

        }
    }
    
    var uploadPhoto: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Let's get your puppy's cutest photo!")
                    .bold()
                    .padding(.bottom, 12)
                    .foregroundColor(.secondaryWhite)
                
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
                                    IconImage(.sfSymbol(.camera, color: .secondaryWhite), width: 36 , height: 36)
                                    
                                    Text("Upload a photo")
                                        .foregroundColor(.secondaryWhite)
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
                    nextButtonPressed()
                }
                Spacer()
                
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    var puppyTips: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    if let icon = viewModel.selectedDogStageDescription?.icon {
                        IconImage(.dogStage(icon, color: .secondaryWhite), width: 200, height: 200)
                            .padding(30)
                    }
                    Spacer()
                }
                .padding()
                
                Text(viewModel.selectedDogStageDescription?.longDescription ?? "")
                    .foregroundColor(.secondaryWhite)
                    .padding(.bottom)
                
                Text("Tips for your dog at this stage")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.secondaryWhite)
                    .padding(.bottom)
                
                if let tips = viewModel.selectedDogStageDescription?.tips {
                    ForEach(tips, id: \.self) { tip in
                        VStack(alignment: .leading) {
                            Text(tip.title)
                                .bold()
                                .foregroundColor(.secondaryWhite)
                                .padding(.bottom, 2)
                            Text(tip.description)
                                .foregroundColor(.secondaryWhite)
                                .padding(.bottom, 12)
                            
                        }
                    }
                }
                Spacer()
                    .frame(height: 50)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            titleGroup
            
            ZStack {
                Color.primaryPurple
                
                TabView(selection: $selectedPage) {
                    puppyName
                        .background(Color.primaryPurple)
                    .tag(0)
                    
                    puppyAge
                        .background(Color.primaryPurple)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(1)
                    
                    puppyBirthday
                        .background(Color.primaryPurple)
                        .tag(2)
                    
                    uploadPhoto
                        .background(Color.primaryPurple)
                    .tag(3)
                    
                    puppyTips
                        .background(Color.primaryPurple)
                    .tag(4)
                }.background(.clear)
                
                VStack {
                    Spacer()
                    ConfirmationButton(title: selectedPage == 4 ? "Complete" : "Next", type: .primaryLargeGradientConfirmation) {
                        nextButtonPressed()
                    }
                    .padding()
                }
                
            }
        }
        .background(Color.primaryPurple, ignoresSafeAreaEdges: .all)
    }
}

struct RegistrationModal_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}


struct WhiteDatePicker: UIViewRepresentable {
    @Binding var date: Date
    var onDone: () -> Void

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.white, forKey: "textColor")
        return datePicker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = date
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: WhiteDatePicker

        init(_ parent: WhiteDatePicker) {
            self.parent = parent
        }

        @objc func done() {
            parent.onDone()
        }
    }
}
