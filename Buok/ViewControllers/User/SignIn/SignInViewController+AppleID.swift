//
//  SignInViewController+AppleID.swift
//  Buok
//
//  Created by 김보민 on 2021/05/09.
//

import AuthenticationServices
import HeroCommon

@available(iOS 13.0, *)
extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
	func configureAppleSignButton() {
		let appleSignButton: ASAuthorizationAppleIDButton
		appleSignButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
		appleSignButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
		appleSignInButton.addSubview(appleSignButton)
	}

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
			let userFirstName: String = appleIDCredential.fullName?.givenName ?? ""
			let userLastName: String = appleIDCredential.fullName?.familyName ?? ""
			let userEmail: String = appleIDCredential.email ?? ""
			let userName: String = userLastName + userFirstName

			let provider = ASAuthorizationAppleIDProvider()
			provider.getCredentialState(forUserID: userId) { (credentialState, error) in
				switch credentialState {
				case .authorized:
					DebugLog("Apple ID Login Authorized")
					//서버 연결 코드 추가 예정
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
		//회원가입 화면
	}
}
