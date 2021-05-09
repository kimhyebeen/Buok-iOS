//
//  SignUpPasswordViewController+UI.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

extension JoinPasswordViewController {
    // MARK: Back Button
    func setupBackButton() {
        // todo - 추후 뒤로가기 아이콘 적용
        backButton.backgroundColor = .systemYellow
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(3)
        }
    }
    
    // MARK: Guide Label
    func setupGuideLabel() {
        guideLabel.font = .font22P
        guideLabel.numberOfLines = 0
        guideLabel.textColor = .heroGray5B
        guideLabel.text = "buok에 오신 것을 환영합니다.\n비밀번호를 설정해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: Password Field
    func setupPasswordField() {
        passwordField.isSecureTextEntry = true
        passwordField.setPlaceHolder("6글자 이상")
        self.view.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: Next Button
    func setupNextButton() {
        nextButton.setHeroTitle("계속하기")
        nextButton.setHeroEnable(false)
        self.view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
