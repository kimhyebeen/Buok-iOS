//
//  SignUpIntroduceViewController+UI.swift
//  Buok
//
//  Created by 김혜빈 on 2021/04/15.
//

import HeroUI

extension SignUpIntroduceViewController {
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
        guideLabel.text = "간단한 소개로\n자신을 표현해주세요."
        self.view.addSubview(guideLabel)
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: Enter Field
    func setupEnterField() {
        enterField.setPlaceHolder("자기소개를 입력해주세요.")
        self.view.addSubview(enterField)
        
        enterField.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.top.equalTo(guideLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
        finishButton.setHeroEnable(false)
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
        passButton.setAttributedTitle(NSAttributedString(string: "건너뛰기", attributes: [.font: UIFont.font17P, .foregroundColor: UIColor.heroGrayA6A4A1]), for: .normal)
        self.view.addSubview(passButton)
        
        passButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(finishButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
