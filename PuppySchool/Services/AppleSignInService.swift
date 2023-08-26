//
//  SignInWithAppleService.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation
import AuthenticationServices

class AppleSignInService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    static let sharedInstance = AppleSignInService()

    var onSignIn: ((Result<String, Error>) -> Void)?
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let idTokenData = appleIDCredential.identityToken, let idTokenString = String(data: idTokenData, encoding: .utf8) else {
                onSignIn?(.failure(NSError(domain: "AppleSignInService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get idToken"])))
                return
            }
            
            onSignIn?(.success(idTokenString))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        onSignIn?(.failure(error))
    }
}
