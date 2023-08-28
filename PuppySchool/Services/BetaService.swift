//
//  BetaService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/28/23.
//

import Foundation
import Firebase

class BetaService: ObservableObject {
    static let sharedInstance = BetaService()
    private var db: Firestore!
    
    @Published var betaEligibleUsers = [String]()
    
    init() {
        db = Firestore.firestore()
    }
    
    func getEligibleUsers() {
        db.collection("beta").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.betaEligibleUsers = querySnapshot!.documents.compactMap { document in
                    document.documentID
                }
            }
        }
    }
}
