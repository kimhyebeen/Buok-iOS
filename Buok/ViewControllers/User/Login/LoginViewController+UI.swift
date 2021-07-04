//
//  SignInViewController+UI.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

extension LoginViewController {
    // MARK: ScrollView
    func setupScrollView() {
        scrollView.addSubview(contentsView)
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: GuideLabel
    func setupGuideLabel() {
        guideLabel.text = "나만의 buok을 만들어 보세요."
        guideLabel.font = .font22P
        guideLabel.textColor = .heroGray5B
        contentsView.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: EmailField
    func setupEmailField() {
        emailField.setPlaceHolder("이메일 주소를 입력해주세요")
        emailField.delegate = self
        contentsView.addSubview(emailField)
        
        emailField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: NextButton
    func setupNextButton() {
        nextButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        nextButton.setHeroTitle("계속하기")
        nextButton.loginButtonType = .none
        nextButton.setHeroEnable(false)
        contentsView.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: OrLabel
    func setupOrLabel() {
        orLabel.text = "또는"
        orLabel.font = .font15P
        orLabel.textColor = .heroGray7A
        contentsView.addSubview(orLabel)
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(72)
            make.centerX.equalToSuperview()
			make.height.equalTo(20)
        }
    }
    
    func setupLoginButtonStackView() {
        contentsView.addSubview(loginButtonStackView)
        loginButtonStackView.axis = .vertical
        loginButtonStackView.spacing = 16
        
        loginButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        setupAppleSignInButton()
        setupGoogleSignInButton()
        setupKakaoSignInButton()
        setupServicePolicyButton()
        
        if #available(iOS 13.0, *) {
            appleSignInButton.isHidden = false
        }
    }
    
    // MARK: AppleSignInButton
    func setupAppleSignInButton() {
        appleSignInButton.setTitle("Apple로 로그인", for: .normal)
        appleSignInButton.loginButtonType = .apple
        loginButtonStackView.addArrangedSubview(appleSignInButton)
        appleSignInButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
        
        appleSignInButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        appleSignInButton.isHidden = true
    }
    
    // MARK: GoogleSignInButton
    func setupGoogleSignInButton() {
        googleSignInButton.setTitle("Google로 로그인", for: .normal)
//        googleSignInButton.setHeroTitle("구글 아이디로 시작하기")
        googleSignInButton.loginButtonType = .google
        loginButtonStackView.addArrangedSubview(googleSignInButton)
        googleSignInButton.addTarget(self, action: #selector(onClickGoogleLogin(_:)), for: .touchUpInside)
        
        googleSignInButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: KakaoSignInButton
    func setupKakaoSignInButton() {
//        kakaoSignInButton.setHeroTitle("카카오톡 아이디로 시작하기")
        kakaoSignInButton.setTitle("카카오톡으로 로그인", for: .normal)
        kakaoSignInButton.loginButtonType = .kakao
        kakaoSignInButton.addTarget(self, action: #selector(onClickKakaoLogin(_:)), for: .touchUpInside)
        loginButtonStackView.addArrangedSubview(kakaoSignInButton)
        
        kakaoSignInButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: ServicePolicyButton
    func setupServicePolicyButton() {
        servicePolicyButton.setAttributedTitle(NSAttributedString(string: "서비스 이용 약관/개인정보 보호 정책", attributes: [.foregroundColor: UIColor.heroGray7A, .font: UIFont.font13P]), for: .normal)
        loginButtonStackView.addArrangedSubview(servicePolicyButton)
        
        servicePolicyButton.snp.makeConstraints { make in
            make.height.equalTo(45)
//            make.centerX.equalToSuperview()
//            make.top.equalTo(kakaoSignInButton.snp.bottom).offset(8)
//            make.bottom.lessThanOrEqualToSuperview().offset(-75)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
