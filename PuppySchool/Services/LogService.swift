//
//  LogService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Foundation
import Firebase

class LogService: ObservableObject {
    static let sharedInstance = LogService()
    private var db: Firestore!
    
    @Published var puppyLogs: [PuppyLog] = []
    @Published var filteredPuppyLogs: [PuppyLog] = []
    
    @Published var logs: [PuppyLog] = [
        PuppyLog(id: "Walk", text: "Went for a walk", type: .walk, createdAt: Date(), updatedAt: Date()),
        PuppyLog(id: "Poop", text: "Took a poop", type: .poop, createdAt: Date(), updatedAt: Date()),
        PuppyLog(id: "Water", text: "Drank some water", type: .water, createdAt: Date(), updatedAt: Date()),
        PuppyLog(id: "Ate", text: "Ate one of the meals for the day", type: .ate, createdAt: Date(), updatedAt: Date()),
        PuppyLog(id: "training", text: "Practiced some training", type: .training, createdAt: Date(), updatedAt: Date()),
    ]
    
    private init() {
        db = Firestore.firestore()
    }
    
    func fetchLogs() {
        db.collection("logs").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting logs: \(err)")
            } else {
                self.logs = querySnapshot?.documents.compactMap { document in
                    return PuppyLog(id: document.documentID, dictionary: document.data())
                } ?? []
            }
        }
    }
    
    func fetchPuppyLogs() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(userId).collection("puppyLogs").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting logs: \(err)")
            } else {
                self.puppyLogs = querySnapshot?.documents.compactMap { document in
                    return PuppyLog(id: document.documentID, dictionary: document.data())
                } ?? []
            }
        }
    }

    func logEvent(log: PuppyLog, completion: @escaping (PuppyLog?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "LogService", code: 1001, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let reference = db.collection("users").document(userId).collection("puppyLogs")
        reference.addDocument(data: log.toDictionary()) { error in
            if let error = error {
                print("Error writing log to Firestore: \(error)")
                completion(nil, error)
            } else {
                completion(log, nil)
            }
        }
    }

    
    
    
    func getLocalLog(byType: PuppyLogType) -> PuppyLog {
        return logs.first { $0.type == byType } ?? PuppyLog(id: "", text: "", type: .ate, createdAt: Date(), updatedAt: Date())
    }
    
    func saveLogs(completion: @escaping (Error?) -> Void) {
        let logRef = db.collection("logs")
        
        let batch = db.batch() // Using batch to save multiple commands at once
        
        for log in self.logs {
            let newRef = logRef.document(log.id) // Generate a new document for each command
            batch.setData(log.toDictionary(), forDocument: newRef)
        }
        
        batch.commit { err in
            completion(err)
        }
    }
}

