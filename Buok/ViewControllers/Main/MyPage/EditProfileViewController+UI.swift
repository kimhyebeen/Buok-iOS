//
//  EditProfileViewController+UI.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

extension EditProfileViewController {
    // MARK: CancelButton
    func setupCancelButton() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.heroGray82, for: .normal)
        cancelButton.titleLabel?.font = .font17P
        cancelButton.addTarget(self, action: #selector(clickCancelButton(_:)), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: TitleLabel
    func setupTitleLabel() {
        titleLabel.text = "프로필 편집"
        titleLabel.textColor = .heroGray82
        titleLabel.font = .font17PBold
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(cancelButton.snp.centerY)
        }
    }
    
    // MARK: FinishButton
    func setupFinishButton() {
        finishButton.setTitle("완료", for: .normal)
        finishButton.setTitleColor(.heroGray82, for: .normal)
        finishButton.titleLabel?.font = .font17P
        finishButton.addTarget(self, action: #selector(clickFinishButton(_:)), for: .touchUpInside)
        self.view.addSubview(finishButton)
        
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: ProfileImageView
    func setupProfileImageView() {
        
    }
    
    // MARK: EditProfileImageButton
    func setupEditProfileImageButton() {
        
    }
    
    // MARK: NicknameLabel
    func setupNicknameLabel() {
        
    }
    
    // MARK: NicknameTextField
    func setupNicknameTextField() {
        
    }
    
    // MARK: NicknameSubLabel
    func setupNicknameSubLabel() {
        
    }
    
    // MARK: NicknameCountLabel
    func setupNicknameCountLabel() {
        
    }
    
    // MARK: IntroduceLabel
    func setupIntroduceLabel() {
        
    }
    
    // MARK: IntroduceTextView
    func setupIntroduceTextView() {
        
    }
    
    // MARK: IntroduceCountLabel
    func setupIntroduceCountLabel() {
        
    }
}
