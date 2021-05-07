//
//  EnterSignInPasswordViewController+UI.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/13.
//

import HeroUI

extension LoginPasswordViewController {
    // MARK: BackButton
    func setupBackButton() {
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        // todo - color 해제 후 backbutton에 아이콘 추가 및 edge inset 적용
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: GuideLabel
    func setupGuideLabel() {
        guideLabel.text = "비밀번호를 입력해주세요."
        guideLabel.font = .font22P
        guideLabel.textColor = .heroGray5B
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: PasswordField
    func setupPasswordField() {
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        passwordField.setPlaceHolder("6글자 이상")
        self.view.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: EyeButton
    func setupEyeButton() {
        eyeButton.addTarget(self, action: #selector(clickEyeButton(_:)), for: .touchUpInside)
        eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye"), for: .normal)
        eyeButton.setImage(UIImage(heroSharedNamed: "ic_eye_fill"), for: .selected)
        self.view.addSubview(eyeButton)
        
        eyeButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.equalTo(passwordField.snp.centerY)
            make.trailing.equalTo(passwordField.snp.trailing).offset(-4)
        }
    }
    
    // MARK: WrongPasswordLabel
    func setupWrongPasswordLabel() {
        wrongPasswordLabel.text = "비밀번호가 틀렸습니다. 다시 입력해주세요."
        wrongPasswordLabel.textColor = .heroServiceSubPink
        wrongPasswordLabel.font = .font13P
        wrongPasswordLabel.isHidden = true
        self.view.addSubview(wrongPasswordLabel)
        
        wrongPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(22)
        }
    }
    
    // MARK: ForgotPasswordButton
    func setupForgotPasswordButton() {
        forgotPasswordButton.setAttributedTitle(NSAttributedString(string: "비밀번호를 잊으셨나요?", attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.heroGray82]), for: .normal)
        self.view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(passwordField.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: LoginButton
    func setupLoginButton() {
        loginButton.setHeroTitle("로그인")
        loginButton.setHeroEnable(false)
        loginButton.addTarget(self, action: #selector(clickLoginButton(_:)), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
