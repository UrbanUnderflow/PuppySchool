//
//  CommandService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/19/23.
//
import Firebase
import Foundation

class CommandService: ObservableObject {
    static let sharedInstance = CommandService()
    private var db: Firestore!
    
    @Published var userCommands: [UserCommand] = []
    @Published var commands: [Command] = [
        // Obedience Commands
        Command(
            id: "Sit",
            name: "Sit",
            description: "Sit down",
            steps: [
                "Hold a treat close to your dog's nose.",
                "Move your hand up, allowing their head to follow the treat and causing their bottom to lower.",
                "Once they’re in a sitting position, say 'Sit,' give them the treat, and share affection."
            ],
            icon: .sit,
            category: .obedience,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Stay",
            name: "Stay",
            description: "Stay in place",
            steps: [
                "Ask your dog to 'Sit.'",
                "Open the palm of your hand in front of you, and say 'Stay.'",
                "Take a few steps back. If they stay, reward them with a treat and affection."
            ],
            icon: .stay,
            category: .obedience,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Down",
            name: "Down",
            description: "Lie Down",
            steps: [
                "Hold a treat in your hand and let them sniff it.",
                "Move your hand to the floor, so they follow.",
                "Slide your hand along the ground to encourage their body to follow their head.",
                "Once they’re down, say 'Down,' give them the treat, and share affection."
            ],
            icon: .down,
            category: .obedience,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Come",
            name: "Come",
            description: "Recall",
            steps: [
                "Put a leash and collar on your dog.",
                "Go down to their level and say 'Come,' while gently pulling on the leash.",
                "When they come to you, reward them with affection and a treat."
            ],
            icon: .come,
            category: .obedience,
            difficulty: .beginner,
            environment: .outdoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Heel",
            name: "Heel",
            description: "Walk by your side without pulling",
            steps: [
                "Start the walk by your side.",
                "If they pull on the leash or go in a different direction, turn around and go the opposite way.",
                "Reward them when they come back to your side with treats and praise."
            ],
            icon: .heel,
            category: .obedience,
            difficulty: .intermediate,
            environment: .outdoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Quiet",
            name: "Quiet",
            description: "Stop barking",
            steps: [
                "When your dog starts barking, say 'Quiet.'",
                "If they stop barking, reward them with a treat and affection.",
                "If they continue barking, redirect their attention with a toy or another command."
            ],
            icon: .quiet,
            category: .obedience,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        //Saftey
        Command(
            id: "Wait",
            name: "Wait",
            description: "Pause before proceeding",
            steps: [
                "Ask your dog to sit or stay.",
                "Open a door or gate just a little, saying 'Wait.'",
                "If your dog stays in place and doesn’t try to push through, reward them with a treat and affection.",
                "Gradually increase the door or gate opening and the time they're asked to wait."
            ],
            icon: .wait,
            category: .safety,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Off",
            name: "Off",
            description: "Not to jump on people",
            steps: [
                "If your dog jumps at you, turn your back to them.",
                "Wait for all four of their feet to be on the ground, then give them attention and a treat.",
                "If they jump again, repeat the process."
            ],
            icon: .off,
            category: .safety,
            difficulty: .beginner,
            environment: .social,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "LeaveIt",
            name: "Leave it",
            description: "Avoid or let go of an item",
            steps: [
                "Place a treat in both hands.",
                "Show them one enclosed fist with the treat inside, and say 'Leave it.'",
                "Let them sniff, lick, mouth, paw, and bark to try to get it, but remain firm.",
                "Once they stop trying, give them the treat from the other hand."
            ],
            icon: .leaveIt,
            category: .safety,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "DropIt",
            name: "Drop it",
            description: "Release an item from their mouth",
            steps: [
                "Play fetch with a toy.",
                "When they have the toy in their mouth, hold a treat out and say 'Drop it.'",
                "Once they release the toy, reward them with the treat."
            ],
            icon: .dropIt,
            category: .safety,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Backup",
            name: "Back up",
            description: "Move backward",
            steps: [
                "Stand in front of your dog and walk towards them.",
                "As they naturally start to move backward, say 'Back up.'",
                "When they've taken a few steps back, reward them with a treat and affection."
            ],
            icon: .backup,
            category: .safety,
            difficulty: .intermediate,
            environment: .outdoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Touch",
            name: "Touch",
            description: "Nose touch to your hand or an object",
            steps: [
                "Hold your hand out in front of your dog's nose (but not too close).",
                "When they move forward to sniff or touch, say 'Touch.'",
                "Reward them immediately with a treat and affection when they make contact."
            ],
            icon: .touch,
            category: .safety,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        //playful
        
        // Continuing from the previous array of commands...
        
        Command(
            id: "Paw",
            name: "Paw/Shake hands",
            description: "Offer a paw for a handshake",
            steps: [
                "Hold a treat in one hand and show it to your dog.",
                "When they naturally lift their paw (usually to tap at the treat), say 'Paw' or 'Shake'.",
                "Reward them with the treat and affection."
            ],
            icon: .paw,
            category: .playful,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Spin",
            name: "Spin",
            description: "Turn around in a circle",
            steps: [
                "Hold a treat close to your dog's nose.",
                "Move your hand in a circle around their head to guide them.",
                "As they complete the circle, say 'Spin'.",
                "Reward them with the treat."
            ],
            icon: .spin,
            category: .playful,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "RollOver",
            name: "Roll over",
            description: "Perform a roll",
            steps: [
                "Ask your dog to lie down.",
                "Hold a treat to their nose and guide it from one side of their head to the other, encouraging them to roll.",
                "As they roll over, say 'Roll over'.",
                "Reward them with the treat."
            ],
            icon: .rollOver,
            category: .playful,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Fetch",
            name: "Fetch",
            description: "Retrieve an item and bring it back",
            steps: [
                "Show your dog a toy and get them excited about it.",
                "Toss the toy and say 'Fetch'.",
                "When they retrieve it, encourage them to come back to you.",
                "Reward them when they bring it back."
            ],
            icon: .fetch,
            category: .playful,
            difficulty: .beginner,
            environment: .outdoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Speak",
            name: "Speak",
            description: "Bark on command",
            steps: [
                "Find something that naturally gets your dog to bark, like a doorbell or a toy.",
                "When they bark, say 'Speak'.",
                "Reward them with a treat and affection."
            ],
            icon: .speak,
            category: .playful,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Tug",
            name: "Tug",
            description: "Play tug with a toy",
            steps: [
                "Hold onto one end of a tug toy and offer the other end to your dog.",
                "Encourage them to grab it and start tugging.",
                "Play tug for a bit, then say 'Drop it' to teach them to let go.",
                "Reward with treats and affection."
            ],
            icon: .tug,
            category: .playful,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "PlayDead",
            name: "Play dead",
            description: "Lie still as if 'dead'",
            steps: [
                "Ask your dog to 'Down' or lie down.",
                "Hold a treat near their nose and move it to the side, encouraging them to roll onto their back.",
                "Once they're on their back and still, say 'Play dead'.",
                "Reward with treats and affection."
            ],
            icon: .playDead,
            category: .playful,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        // Advanced movement
        
        Command(
            id: "Stand",
            name: "Stand",
            description: "Stand up from a sitting or lying position",
            steps: [
                "Hold a treat just above your dog's nose.",
                "Move the treat upwards and slightly forwards.",
                "As your dog rises to its feet, say 'Stand'.",
                "Reward them with the treat."
            ],
            icon: .stand,
            category: .advanced,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Turn",
            name: "Turn",
            description: "Make a sharp turn while walking",
            steps: [
                "While walking your dog, hold a treat to their nose.",
                "Guide them in the desired direction with the treat.",
                "As they make the turn, say 'Turn'.",
                "Reward them with the treat."
            ],
            icon: .turn,
            category: .advanced,
            difficulty: .intermediate,
            environment: .outdoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "LegWeave",
            name: "Leg weave",
            description: "Weave through your legs as you walk",
            steps: [
                "Hold a treat in your hand and guide your dog through your legs.",
                "As they follow the treat, walk forward, allowing them to weave through.",
                "Once they've weaved through, say 'Leg weave'.",
                "Reward them with the treat."
            ],
            icon: .legWeave,
            category: .advanced,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "GoAround",
            name: "Go around",
            description: "Go around an object or person",
            steps: [
                "Place an object in front of your dog.",
                "Guide them around the object using a treat.",
                "As they complete the circle, say 'Go around'.",
                "Reward them with the treat."
            ],
            icon: .goAround,
            category: .advanced,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Over",
            name: "Over",
            description: "Jump over an obstacle",
            steps: [
                "Place a low obstacle in front of your dog.",
                "Hold a treat on the opposite side of the obstacle.",
                "Guide them over the obstacle with the treat and say 'Over'.",
                "Reward them with the treat."
            ],
            icon: .over,
            category: .advanced,
            difficulty: .intermediate,
            environment: .outdoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Under",
            name: "Under",
            description: "Go under an obstacle or object",
            steps: [
                "Place an obstacle that's high enough for your dog to crawl under.",
                "Hold a treat on the opposite side of the obstacle.",
                "Guide them under the obstacle with the treat and say 'Under'.",
                "Reward them with the treat."
            ],
            icon: .under,
            category: .advanced,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Crawl",
            name: "Crawl",
            description: "Crawl on the ground without standing up",
            steps: [
                "Have your dog lie down.",
                "Hold a treat just in front of their nose and move it forward slowly.",
                "As they crawl forward, say 'Crawl'.",
                "Reward them with the treat."
            ],
            icon: .crawl,
            category: .advanced,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adult,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Weave",
            name: "Weave",
            description: "Weave between multiple objects or poles",
            steps: [
                "Set up multiple poles or objects in a line.",
                "Hold a treat in your hand and guide your dog in a weaving pattern through the poles.",
                "As they weave through, say 'Weave'.",
                "Reward them with the treat."
            ],
            icon: .weave,
            category: .advanced,
            difficulty: .advanced,
            environment: .outdoor,
            dogStage: .adult,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        // Problem-Solving/Task-Oriented Commands
        
        Command(
            id: "Place",
            name: "Place",
            description: "Go to a specific spot or bed",
            steps: [
                "Point to the designated spot or bed.",
                "Say 'Place' in a clear, calm voice.",
                "When your dog moves to the spot, reward them with a treat."
            ],
            icon: .place,
            category: .task,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "TakeIt",
            name: "Take it",
            description: "Pick up a specific item",
            steps: [
                "Hold the item close to your dog's mouth.",
                "Say 'Take it' in a clear voice.",
                "When they take the item, reward them with a treat."
            ],
            icon: .takeIt,
            category: .task,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "FindIt",
            name: "Find it",
            description: "Search for a hidden item or person",
            steps: [
                "Show your dog the item or person.",
                "Hide the item or person.",
                "Say 'Find it' in a clear voice.",
                "Reward them with a treat when they locate the item or person."
            ],
            icon: .findIt,
            category: .task,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Hold",
            name: "Hold",
            description: "Hold an item without chewing",
            steps: [
                "Offer your dog an item to hold in their mouth.",
                "Say 'Hold' in a clear voice.",
                "If they hold without chewing, reward them with a treat."
            ],
            icon: .hold,
            category: .task,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Settle",
            name: "Settle",
            description: "Calm down",
            steps: [
                "In a calm environment, ask your dog to sit or lie down.",
                "Say 'Settle' in a soothing voice.",
                "Reward them with gentle petting or a calm treat."
            ],
            icon: .settle,
            category: .task,
            difficulty: .beginner,
            environment: .indoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        // Playful/Trick Commands
        
        Command(
            id: "Bow",
            name: "Bow",
            description: "Take a bow position",
            steps: [
                "Hold a treat close to your dog's nose.",
                "Move the treat down towards their paws.",
                "As they reach and stretch into a bow, say 'Bow'.",
                "Reward them with the treat."
            ],
            icon: .bow,
            category: .playful,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Dance",
            name: "Dance",
            description: "Stand on hind legs and twirl",
            steps: [
                "Hold a treat above your dog's head.",
                "Move the treat in a circle so they twirl.",
                "As they dance around, say 'Dance'.",
                "Reward them with the treat."
            ],
            icon: .dance,
            category: .playful,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adult,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "PeekABoo",
            name: "Peek-a-boo",
            description: "Hide their face with their paws",
            steps: [
                "Hold a treat close to their nose.",
                "Move the treat behind their head.",
                "As they move their paws up to follow the treat, say 'Peek-a-boo'.",
                "Reward them with the treat."
            ],
            icon: .peekABoo,
            category: .playful,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adult,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Jump",
            name: "Jump",
            description: "Jump on command",
            steps: [
                "Hold a treat just above their head level.",
                "Say 'Jump' in a clear voice.",
                "When they jump, reward them with the treat."
            ],
            icon: .jump,
            category: .playful,
            difficulty: .beginner,
            environment: .outdoor,
            dogStage: .puppy,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Balance",
            name: "Balance",
            description: "Balance a treat on their nose",
            steps: [
                "Ask your dog to sit.",
                "Place a treat on their nose.",
                "Say 'Balance'.",
                "When they hold still without dropping the treat, reward them with it."
            ],
            icon: .balance,
            category: .playful,
            difficulty: .advanced,
            environment: .indoor,
            dogStage: .adult,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        ),
        
        Command(
            id: "Hug",
            name: "Hug",
            description: "Give a hug with their paws",
            steps: [
                "Stand in front of your dog.",
                "Say 'Hug' and offer your arms.",
                "When they put their paws around you, reward them with a treat."
            ],
            icon: .hug,
            category: .playful,
            difficulty: .intermediate,
            environment: .indoor,
            dogStage: .adolescent,
            completionMax: 60,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]
    
    
    private init() {
        db = Firestore.firestore()
    }
    
    func saveCommands(completion: @escaping (Error?) -> Void) {
        let commandsRef = db.collection("commands")
        
        let batch = db.batch() // Using batch to save multiple commands at once
        
        for command in self.commands {
            let newCommandRef = commandsRef.document(command.id) // Generate a new document for each command
            batch.setData(command.toDictionary(), forDocument: newCommandRef)
        }
        
        batch.commit { err in
            completion(err)
        }
    }
    
    func getUserCommand(command: Command) -> UserCommand? {
        return userCommands.first { $0.command.id == command.id }
    }
    
    func updateUserCommandInArray(updatedUserCommand: UserCommand) {
        if let index = userCommands.firstIndex(where: { $0.id == updatedUserCommand.id }) {
            userCommands[index] = updatedUserCommand
        } else {
            print("UserCommand not found in the array!")
        }
    }
    
    func updateUserCommand(userCommand: UserCommand) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        var userCommand = userCommand
        let userCommandRef = db.collection("users").document(userId).collection("userCommands").document(userCommand.id)

        userCommandRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userCommandRef.updateData(userCommand.toDictionary()) { error in
                    if let error = error {
                        print("Error updating user command: \(error)")
                    } else {
                        print("User command successfully updated!")
                    }
                }
            } else {
                userCommandRef.setData(userCommand.toDictionary()) { error in
                    if let error = error {
                        print("Error creating user command: \(error)")
                    } else {
                        print("User command successfully created!")
                    }
                }
            }
        }
    }
    
    func loadCommands() {
        // Assuming you have a collection named "commands" in Firestore
        db.collection("commands").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting commands: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No commands found")
                return
            }

            // Assuming you have a Command model that can be initialized from a Firestore document
            self.commands = documents.compactMap { (document) -> Command? in
                return Command(id: document.documentID, dictionary: document.data())
            }
        }
    }
    
    func fetchUserCommands(completion: @escaping ([UserCommand], Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion([], nil)
            return
        }

        let userCommandsRef = db.collection("users").document(userId).collection("userCommands")

        // Fetch all command documents for the user
        userCommandsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion([], error)
                return
            }

            guard let snapshot = snapshot else {
                completion([], nil)
                return
            }

            var userCommands: [UserCommand] = []

            for document in snapshot.documents {
                if let userCommand = UserCommand(id: document.documentID, dictionary: document.data()) {
                    userCommands.append(userCommand)
                }
            }
            self.userCommands = userCommands
            
            completion(userCommands, nil)
        }
    }

}
