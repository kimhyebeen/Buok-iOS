//
//  LoginViewController+AppleID.swift
//  Buok
//
//  Created by 김보민 on 2021/05/09.
//

import AuthenticationServices
import HeroCommon

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
	func configureAppleSignButton() {
		let appleSignButton: ASAuthorizationAppleIDButton
		if #available(iOS 13.2, *), viewModel.appleLoginMode == false {
			appleSignButton = ASAuthorizationAppleIDButton(type: .signUp, style: .white)
		} else {
			appleSignButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
		}
		appleSignButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
		contentsView.addSubview(appleSignButton)
		
		appleSignButton.snp.makeConstraints { make in
			make.top.equalTo(orLabel.snp.bottom).offset(20)
			make.leading.equalToSuperview().offset(20)
			make.trailing.equalToSuperview().offset(-20)
			make.height.equalTo(48)
		}
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
			let _: String = appleIDCredential.email ?? ""
			let _: String = userLastName + userFirstName

			let provider = ASAuthorizationAppleIDProvider()
			provider.getCredentialState(forUserID: userId) { credentialState, error in
				switch credentialState {
				case .authorized:
					DebugLog("Apple ID Login Authorized")
					// 서버 연결 코드 추가 예정
					self.viewModel.appleLoginMode = true
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
