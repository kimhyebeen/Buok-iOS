//
//  SignUpIntroduceViewController+UI.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

extension JoinIntroduceViewController {
    // MARK: Back Button
    func setupBackButton() {
        // todo - 추후 뒤로가기 아이콘 적용
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
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
        guideLabel.text = "간단한 소개로\n자신을 표현해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: Enter Field
    func setupEnterField() {
        enterField.isScrollEnabled = false
        enterField.delegate = self
        self.view.addSubview(enterField)
        
        enterField.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.top.equalTo(guideLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: Placeholder
    func setupPlaceholder() {
        placeholder.text = "자기소개를 입력해주세요 (최대 3줄)"
        placeholder.textColor = .heroGrayDA
        placeholder.font = .font15P
        self.view.addSubview(placeholder)
        
        placeholder.snp.makeConstraints { make in
            make.top.equalTo(enterField.snp.top).offset(16)
            make.leading.equalTo(enterField.snp.leading).offset(16)
        }
    }
    
    // MARK: Count Label
    func setupCountLabel() {
        countLabel.text = "0/75"
        countLabel.font = .font13P
        countLabel.textColor = .heroGrayA8
        self.view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(enterField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
    
    // MARK: Finish Button
    func setupFinishButton() {
        finishButton.setHeroTitle("완료")
        finishButton.loginButtonType = .none
        finishButton.setHeroEnable(false)
        finishButton.addTarget(self, action: #selector(clickFinishButton(_:)), for: .touchUpInside)
        self.view.addSubview(finishButton)
        
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(enterField.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: Pass Button
    func setupPassButton() {
        passButton.addTarget(self, action: #selector(clickPassButton(_:)), for: .touchUpInside)
        passButton.setAttributedTitle(NSAttributedString(string: "건너뛰기", attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.heroGrayA6A4A1]), for: .normal)
        self.view.addSubview(passButton)
        
        passButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(finishButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
