//
//  CheckListService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/20/23.
//

import Firebase
import Foundation

class CheckListService: ObservableObject {
    static let sharedInstance = CheckListService()
    private var db: Firestore!
    
    @Published var checklistItems: [CheckListItem] = []
    
    private init() {
        db = Firestore.firestore()
    }
    
    func loadCheckListItems() {
        db.collection("checklist").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting checklist items: \(err)")
            } else {
                self.checklistItems = querySnapshot?.documents.compactMap { document in
                    return CheckListItem(id: document.documentID, dictionary: document.data())
                } ?? []
            }
        }
    }
    
    func saveChecklistItems(completion: @escaping (Error?) -> Void) {
        let listRef = db.collection("checklist")
        
        let batch = db.batch() // Using batch to save multiple commands at once
        
        for listItem in CheckListData.shared.data {
            let newListRef = listRef.document(listItem.id) // Generate a new document for each command
            batch.setData(listItem.toDictionary(), forDocument: newListRef)
        }
        
        batch.commit { err in
            completion(err)
        }
    }
}
