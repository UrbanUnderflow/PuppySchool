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
    @Published var previousCommand: UserCommand?
    @Published var commands: [Command] = CommandData.shared.data
    
    
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
            self.previousCommand = userCommands.max { $0.updatedAt < $1.updatedAt }
            completion(userCommands, nil)
        }
    }
}
