//
//  LoginViewController+AppleID.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import AuthenticationServices
import HeroCommon

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @objc
    func appleSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId: String = appleIDCredential.user
            var email : String = appleIDCredential.email ?? ""
            
            let provider = ASAuthorizationAppleIDProvider()
            provider.getCredentialState(forUserID: userId) { credentialState, error in
                switch credentialState {
                case .authorized:
                    DebugLog("Apple ID Login Authorized")
                    self.viewModel.appleLoginMode = true
                    self.viewModel.socialType.value = .apple
                    self.viewModel.requestSNSJoinandLogin(email: email, socialId: "\(userId)")
                case .notFound:
                    DebugLog("Apple ID Login Not Found")
                case .revoked:
                    DebugLog("Apple ID Login Revoked")
                default: break
                }
            }
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        DebugLog("Apple ID Login Fail")
    }
}
