//
//  FirebaseService.swift
//  QuickLifts
//
//  Created by Tremaine Grant on 6/27/23.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import AuthenticationServices

enum FirebaseError: Error {
    case invalidCredentials
    case emailAlreadyInUse
    case unknownError
}

class FirebaseService: NSObject  {
    static let sharedInstance = FirebaseService()
    private var db: Firestore!
    var currentAuthorizationController: ASAuthorizationController?

    private override init() {
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    
    var isAuthenticated: Bool {
        guard (Auth.auth().currentUser?.uid) != nil else {
            return false
        }
        
        return true
    }
    
    func signInAnonymously(completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signInAnonymously(completion: completion)
    }
    
    func signInWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let authResult = authResult else {
                completion(.failure(FirebaseError.unknownError))
                return
            }
            
            let uid = authResult.user.uid
            
            self.db.collection("users").document(uid).getDocument { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = snapshot?.data(),
                      let user = User(id: snapshot?.documentID ?? "", dictionary: data) else {
                          completion(.failure(FirebaseError.unknownError))
                          return
                }
                
                self.logLoginEvent(method: "email")
                completion(.success(user))
            }
        }
    }
    
    func signUpWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                self.logSignUpEvent(method: "email")
                completion(.success(authResult))
            } else {
                // This case should never occur, but handle it anyway
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
            }
        }
    }
    
    func signInWithApple(idTokenString: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nil)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                self.logLoginEvent(method: "apple")
                completion(.success(authResult))
            } else {
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
            }
        }
    }

    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(FirebaseError.unknownError))
            return
        }
        
        // Delete user's authentication
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.logDeleteAccountEvent()
                completion(.success(true))
            }
        }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.6),
              let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data or user id"])))
            return
        }

        let storageRef = Storage.storage().reference().child(userId).child("profile_images").child("images").child("\(userId).jpg")
        storageRef.putData(data, metadata: nil) { (_, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                    self.logImageUploadEvent()
                }
            }
        }
    }
    
    let imageCache = NSCache<NSURL, UIImage>()

    func image(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Failed to load image with error: \(error.localizedDescription)")
                    completion(nil)
                } else if let data = data, let image = UIImage(data: data) {
                    self?.imageCache.setObject(image, forKey: url as NSURL)
                    completion(image)
                }
            }.resume()
        }
    }

    func fetchImage(with url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to image"])))
                }
            }
        }.resume()
    }
    
    func createUserObject() {
        // Create a user object when a person first opens the app.
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let email = Auth.auth().currentUser?.email else {
            return
        }
        
        let userRef = db.collection("users").document(userId)
        
        // Check if user document already exists
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, !document.exists else {
                print("User document already exists")
                return
            }
            
            // Create new user document
            userRef.setData([
                "email": email,
                "createdAt": Date().timeIntervalSince1970,
                "updatedAt": Date().timeIntervalSince1970,
            ]) { (error) in
                if let error = error {
                    print("Error creating user document: \(error.localizedDescription)")
                } else {
                    print("User document created successfully")
                    UserService.sharedInstance.user = User(id: userId, email: email, birthdate: Date(), dogName: "", dogStage: .puppy, profileImageURL: nil, subscriptionType: .free, createdAt: Date(), updatedAt: Date())
                }
            }
        }
    }

    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser, let email = currentUser.email else {
            completion(.failure(FirebaseError.unknownError))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        
        currentUser.reauthenticate(with: credential) { (_, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            currentUser.updatePassword(to: newPassword) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(true))
            }
        }
    }

   func signOut() throws {
       try Auth.auth().signOut()
   }
    
    ///Analytics events
    ///
    // Log a custom event
    func logCustomEvent(name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }

    // Log a sign-up event
    func logSignUpEvent(method: String) {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: [
            AnalyticsParameterMethod: method
        ])
    }

    // Log a login event
    func logLoginEvent(method: String) {
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
            AnalyticsParameterMethod: method
        ])
    }

    // Log an image upload event
    func logImageUploadEvent() {
        Analytics.logEvent("image_upload", parameters: nil)
    }
    
    func logDeleteAccountEvent() {
        Analytics.logEvent("delete_account", parameters: nil)
    }
    
    func logPurchaseAttemptEvent(package: String) {
        Analytics.logEvent("purchase_attempt", parameters: [
            AnalyticsParameterMethod: package
        ])
    }
    
    func logSuccessfulPurchase(package: String) {
        Analytics.logEvent("purchase_success", parameters: [
            AnalyticsParameterMethod: package
        ])
    }
    
    func logFailedPurchase(package: String) {
        Analytics.logEvent("purchase_failed", parameters: [
            AnalyticsParameterMethod: package
        ])
    }
    
    func logTrainingTapped(module: String) {
        Analytics.logEvent("training_tapped", parameters: [
            AnalyticsParameterMethod: module
        ])
    }
    
    func logStartTrainingSession(module: String) {
        Analytics.logEvent("training_started", parameters: [
            AnalyticsParameterMethod: module
        ])

    }
    
    func logCompletedTraining(successRate: String) {
        Analytics.logEvent("training_ended", parameters: [
            AnalyticsParameterMethod: successRate
        ])
    }
    
    func logAddToLogEvent(event: String) {
        Analytics.logEvent("add_log", parameters: [
            AnalyticsParameterMethod: event
        ])
    }
    
    func logPurchaseItem(item: String) {
        Analytics.logEvent("purchase_item", parameters: [
            AnalyticsParameterMethod: item
        ])
    }
    
    func logAddToLogEventFailed(error: String) {
        Analytics.logEvent("add_log_failed", parameters: [
            AnalyticsParameterMethod: error
        ])
    }
    
    func logCompleteRegistration() {
        Analytics.logEvent("registration_complete", parameters: nil)
    }
    
    func logRegisterNextPage(page: Int) {
        Analytics.logEvent("registration_page", parameters: [
            AnalyticsParameterMethod: page
        ])
    }
    
}
