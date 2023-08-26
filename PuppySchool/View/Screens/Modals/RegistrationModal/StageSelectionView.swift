//
//  MultipleChoiceView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/22/23.
//
import Foundation
import SwiftUI

class StageSelectionViewModel: ObservableObject {
    @Published var options: [DogStageDescription] = [
        DogStageDescription(id: UUID(),
                            title: "Get ready for a life of dog parenthood!",
                            stage: DogStage.puppy,
                            icon: .puppyStage,
                            description: "Puppy is highly receptive to new experiences, making it an ideal time for socialization and foundational training.",
                            longDescription: """
                                The imprint stage is a crucial period in a dog's life, brimming with rapid growth and boundless curiosity. It's akin to the toddler years in humans. Puppies at this age are like little sponges, eager to explore and absorb everything around them. This makes it the prime time to lay the foundation for a well-rounded adult dog. Their brain is incredibly plastic, and they're forming associations about the world that will stick with them for life. It's vital to ensure those associations are positive. Prioritize socialization, expose them gently to a myriad of environments, sounds, and experiences. Remember, this is not just about obedience training – it's about shaping their perception of the world. Be patient, consistent, and loving. Approach training with a blend of structure, fun, and plenty of rewards. Positive reinforcements at this stage not only instill good behavior but also build a trusting bond between you and your puppy.
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
                            ageRange: "3-14 weeks"),
        DogStageDescription(id: UUID(),
                            title: "Your pup has energy, lets use it to their advantage!",
                            stage: DogStage.adolescent,
                            icon: .adolescentStage,
                            description: "Puppy undergo's significant physical and mental changes. Energy levels surge, and they can become more independent.",
                            longDescription: """
                            The adolescent stage is often likened to the 'teenage years' in dogs. Your pup is transitioning from that cute, cuddly ball of fur into a more independent and sometimes, challenging young adult. They're filled with newfound energy, and hormones, and are starting to test boundaries as they seek independence. Just like human teenagers, adolescent dogs might occasionally exhibit stubbornness or selective hearing. \n\nHowever, this is also a period where their personality shines through. While they may have mastered basic commands during their puppy days, the adolescent stage can sometimes feel like taking two steps back. It's essential to reinforce earlier training, establish consistent boundaries, and maintain patience. Engaging them in activities that channel their energy constructively, such as agility training or longer play sessions, can be incredibly beneficial. Remember, they're not acting out to be defiant; they're merely navigating their growth and independence. Continue to nurture your bond, provide guidance, and understand that with the right approach, this phase too shall pass, leading to a mature, well-behaved adult dog.
                            """,
                            tips: [
                                DogStageTips(id: UUID(), title: "Consistency is Key", description: "Adolescents will test boundaries. It's essential to remain consistent with the rules you've set to ensure they don't pick up bad habits."),
                                DogStageTips(id: UUID(), title: "Reinforce Basic Commands", description: "Even if your dog learned basic commands during the imprint stage, continue to practice and reinforce them."),
                                DogStageTips(id: UUID(), title: "Exercise", description: "Adolescent dogs have a lot of energy. Regular physical activity can help reduce destructive behaviors. Activities like fetch, tug-of-war, and long walks are beneficial."),
                                DogStageTips(id: UUID(), title: "Mental Stimulation", description: "Mental workouts can be as tiring as physical ones. Use puzzle toys, teach new tricks, or try out dog sports like agility or obedience competitions."),
                                DogStageTips(id: UUID(), title: "Socialization", description: "Continue to expose your adolescent dog to new environments and experiences. Reward positive interactions with treats and praise."),
                                DogStageTips(id: UUID(), title: "Address Unwanted Behaviors", description: "Jumping, barking, or digging can become prominent during this stage. Address these behaviors early through training techniques like redirection."),
                                DogStageTips(id: UUID(), title: "Stay Positive", description: "Avoid punishment-based training. It can harm your relationship with your dog and often isn't effective. Instead, use positive reinforcement techniques."),
                                DogStageTips(id: UUID(), title: "Chewing", description: "Chewing can continue into adolescence, especially when teething. Ensure your dog has appropriate toys to chew on and keep valuables out of reach."),
                                DogStageTips(id: UUID(), title: "Recall Training", description: "With their newfound independence, adolescents might not come when called. Reinforce recall commands in various environments to ensure safety."),
                                DogStageTips(id: UUID(), title: "Continue Crate Training", description: "If you started crate training in the imprint stage, keep it up. The crate can be a safe space for your adolescent dog, especially when they're feeling overwhelmed."),
                                DogStageTips(id: UUID(), title: "Patience", description: "Adolescence can be a challenging period for dog owners. Remember, your dog isn't being 'bad' on purpose. They're growing and learning. Stay patient and understanding."),
                                DogStageTips(id: UUID(), title: "Regular Check-ups", description: "Continue with regular vet visits. Discuss any behavioral or health concerns related to adolescence."),
                                DogStageTips(id: UUID(), title: "Consider Neutering/Spaying", description: "Discuss with your vet the best time to neuter or spay your dog. This can sometimes help with certain adolescent behaviors, but it's essential to weigh the pros and cons.")
                            ],
                            ageRange: "6 months - 2 years"),
        DogStageDescription(id: UUID(),
                            title: "A dog is never too old to learn new tricks!",
                            stage: DogStage.adult,
                            icon: .adultStage,
                            description: "Dog outgrown's the impulsive, hyperactive behavior. Personalities, temperaments, and behaviors are well-established.",
                            longDescription: """
                            As your dog enters the adult stage, you'll notice a marked shift from the energetic, sometimes unpredictable adolescent phase. This period signifies stability and maturity, as your dog settles into its personality and habits. Adult dogs have typically grown out of the impulsive behaviors of youth and are often more predictable and relaxed. \n\nHowever, this doesn't mean training and learning come to a halt. In fact, it's a wonderful time to deepen your bond, refine skills, and even introduce new ones. Their cognitive functions are at their peak, making them great candidates for advanced training or even re-learning commands that might have been forgotten. It's also the time to be vigilant about health and nutrition, ensuring they receive adequate exercise and a balanced diet to maintain optimal weight and overall health. Regular vet check-ups are crucial to detect any potential issues early. As they age, they might need adjustments in their routine to accommodate any changes in energy levels or health. Remember, consistency, understanding, and love remain key components in nurturing your relationship with your adult dog, ensuring it feels secure and valued.
                            """,
                            tips: [
                                DogStageTips(id: UUID(), title: "Continuous Training", description: "While your dog may know basic commands, continuous training helps reinforce good behaviors and keeps their skills sharp."),
                                DogStageTips(id: UUID(), title: "Routine", description: "Adult dogs thrive on routine. Keeping a consistent schedule for meals, walks, and playtime can provide comfort and predictability."),
                                DogStageTips(id: UUID(), title: "Exercise", description: "While they might not have the boundless energy of a puppy, adult dogs still need regular exercise to keep fit and prevent obesity. Tailor activities to your dog's energy level and interests."),
                                DogStageTips(id: UUID(), title: "Mental Stimulation", description: "Just like their younger counterparts, adult dogs benefit from mental challenges. Rotate toys, introduce puzzle feeders, and teach new tricks or commands."),
                                DogStageTips(id: UUID(), title: "Social Interaction", description: "Ensure your dog has opportunities for positive interactions with other dogs and people. Regular socialization can prevent behavior issues related to fear or aggression."),
                                DogStageTips(id: UUID(), title: "Reinforce Good Behavior", description: "Use positive reinforcement techniques, rewarding your dog for desired behaviors. This approach is more effective and strengthens your bond."),
                                DogStageTips(id: UUID(), title: "Address Behavioral Issues", description: "If new behavior problems arise, address them promptly. Consider seeking the help of a professional dog trainer if needed."),
                                DogStageTips(id: UUID(), title: "Health Check-ups", description: "Regular vet visits are essential to monitor for any health issues that can arise in adulthood. Preventative care is key."),
                                DogStageTips(id: UUID(), title: "Diet", description: "As dogs age, their dietary needs might change. Ensure you're feeding a balanced diet suitable for an adult dog. Monitor weight and adjust portions as needed."),
                                DogStageTips(id: UUID(), title: "Avoid Boredom", description: "A bored dog can develop destructive behaviors. Engage them with toys, activities, and interactive play sessions."),
                                DogStageTips(id: UUID(), title: "Grooming", description: "Regular grooming is essential, even if your dog was accustomed to it as a puppy. It helps you monitor for health issues and ensures your dog is comfortable."),
                                DogStageTips(id: UUID(), title: "Patience and Understanding", description: "As dogs age, they might not be as quick or eager as they once were. Be patient, understanding, and adapt training sessions to their pace.")
                            ],
                            ageRange: "2-3 years")
    ]
}

struct StageSelectionView: View {
    @ObservedObject var viewModel: StageSelectionViewModel
    let onSubmittedAnswer: (DogStageDescription) -> Void
    @State var selectedOption: DogStageDescription?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack {
                ForEach(viewModel.options) { option in
                    Button(action: {
                        selectedOption = option
                        onSubmittedAnswer(option)
                    }) {
                        VStack {
                            HStack {
                                VStack(alignment: .center, spacing:0) {
                                    IconImage(.dogStage(option.icon, color: selectedOption?.stage == option.stage ? Color.secondaryPink : .secondaryWhite), width: 50, height: 50)
                                    Text(option.stage.rawValue.capitalized)
                                        .foregroundColor(selectedOption?.stage == option.stage ? Color.secondaryPink : .secondaryWhite)
                                        .font(.title3)
                                        .bold()
                                        .padding(.bottom, 5)
                                }
                                .frame(width: 150)
                                Text(option.description)
                                    .multilineTextAlignment(.leading)
                                    .font(.subheadline)
                                    .foregroundColor(selectedOption?.stage == option.stage ? Color.secondaryPink : Color.secondaryWhite)
                                    .bold()
                                    .padding()
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(option.ageRange)
                                        .font(.subheadline)
                                        .padding(.trailing, 20)
                                        .foregroundColor(Color.secondaryPink)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(Color.darkPurple)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                selectedOption?.stage == option.stage ? Color.secondaryPink : Color.clear,
                                lineWidth: 2
                            )
                    )
                    .background(selectedOption?.stage == option.stage ? Color.primaryPurple.opacity(0.1) : Color.clear)
                }
            }
            .padding(.horizontal, 26)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            if let item = viewModel.options.first {
                selectedOption = item
            }
        }
    }
}


struct StageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
            StageSelectionView(viewModel: StageSelectionViewModel(), onSubmittedAnswer: { selectedOptions in
                print("Selected options: \(selectedOptions)")
            })
        }
    }
}

