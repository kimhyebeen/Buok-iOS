//
//  SignInViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI
import SnapKit

public class LoginViewController: HeroBaseViewController {
    let scrollView: UIScrollView = UIScrollView()
    let contentsView: UIView = UIView()
    let loginButtonStackView: UIStackView = UIStackView()
    
    let guideLabel = UILabel()
    let emailField = UserTextField()
    let nextButton = LoginButton()
    let orLabel = UILabel()
    let appleSignInButton = LoginButton()
    let googleSignInButton = LoginButton()
    let kakaoSignInButton = LoginButton()
    let servicePolicyButton = UIButton()
    
    var viewModel = UserViewModel()
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		
        TokenManager.shared.deleteAllTokenData()
        
        viewModel.isEmailExist.bind({ isExist in
            guard let isExist = isExist else {
                // todo - 로그인 성공도 아니고, not found도 아님
                return
            }
            if isExist {
                let loginPasswordVC = LoginPasswordViewController()
                loginPasswordVC.viewModel = self.viewModel
                self.navigationController?.pushViewController(loginPasswordVC, animated: true)
            } else {
                let joinVC = JoinViewController()
                joinVC.viewModel = self.viewModel
                self.navigationController?.pushViewController(joinVC, animated: true)
            }
        })
		setupView()
	}
    
    private func setupView() {        
        setupScrollView()
        setupGuideLabel()
        setupEmailField()
        setupNextButton()
        setupOrLabel()
        setupLoginButtonStackView()
//        setupAppleSignInButton()
//        setupGoogleSignInButton()
//        setupKakaoSignInButton()
//        setupServicePolicyButton()
        
        setupTapGesture()
//		if #available(iOS 13.0, *) {
//			configureAppleSignButton()
//		}
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.delegate = self
        scrollView.addGestureRecognizer(tap)
    }
    
    @objc
    func onClickGoogleLogin(_ sender: UIButton) {
        
    }
    
    @objc
    func onClickKakaoLogin(_ sender: UIButton) {
        viewModel.requestKakaoTalkLogin()
    }
    
    @objc
    func clickNextButton(_ sender: UIButton) {
        guard let email = emailField.text else { return }
        viewModel.checkEmailExist(email)
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        nextButton.setHeroEnable(viewModel.validateEmail(textField.text ?? ""))
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
