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
        profileImageView.layer.backgroundColor = UIColor.systemYellow.cgColor
        // todo - 이미지 넣어주기
        profileImageView.layer.cornerRadius = 44
        profileImageView.clipsToBounds = true
        self.view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: EditProfileImageButtonBackgroundCircle
    func setupEditProfileImageButtonBackgroundCircle() {
        editProfileImageButtonBackgroundCircle.layer.cornerRadius = 16
        editProfileImageButtonBackgroundCircle.layer.backgroundColor = UIColor.white.cgColor
        self.view.addSubview(editProfileImageButtonBackgroundCircle)
        
        editProfileImageButtonBackgroundCircle.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(4)
            make.trailing.equalTo(profileImageView.snp.trailing).offset(4)
        }
    }
    
    // MARK: EditProfileImageButton
    func setupEditProfileImageButton() {
        if #available(iOS 13.0, *) {
            editProfileImageButton.setImage(UIImage(heroSharedNamed: "ic_camera")!.withTintColor(.heroGray82), for: .normal)
        } else {
            editProfileImageButton.setImage(UIImage(heroSharedNamed: "ic_camera")!, for: .normal)
        }
        editProfileImageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        editProfileImageButton.addTarget(self, action: #selector(clickEditProfileImageButton(_:)), for: .touchUpInside)
        self.view.addSubview(editProfileImageButton)
        
        editProfileImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.center.equalTo(editProfileImageButtonBackgroundCircle.snp.center)
        }
        
    }
    
    // MARK: NicknameLabel
    func setupNicknameLabel() {
        nicknameLabel.text = "별칭"
        nicknameLabel.textColor = .heroGray82
        nicknameLabel.font = .font15P
        self.view.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: NicknameTextField
    func setupNicknameTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.textFont = .font15P
        nicknameTextField.setPlaceHolder("별칭을 입력해주세요")
        self.view.addSubview(nicknameTextField)
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: NicknameSubLabel
    func setupNicknameSubLabel() {
        nicknameSubLabel.isHidden = true
        nicknameSubLabel.text = "중복된 별칭입니다."
        nicknameSubLabel.textColor = .heroServiceSubPink
        nicknameSubLabel.font = .font13P
        self.view.addSubview(nicknameSubLabel)
        
        nicknameSubLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: NicknameCountLabel
    func setupNicknameCountLabel() {
        nicknameCountLabel.text = "0/12"
        nicknameCountLabel.textColor = .heroGrayA6A4A1
        nicknameCountLabel.font = .font13P
        self.view.addSubview(nicknameCountLabel)
        
        nicknameCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
    
    // MARK: IntroduceLabel
    func setupIntroduceLabel() {
        introduceLabel.text = "자기소개"
        introduceLabel.textColor = .heroGray82
        introduceLabel.font = .font15P
        self.view.addSubview(introduceLabel)
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: IntroduceTextView
    func setupIntroduceTextView() {
        introduceTextView.delegate = self
        self.view.addSubview(introduceTextView)
        
        introduceTextView.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.top.equalTo(introduceLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: IntroducePlaceholder
    func setupIntroducePlaceholder() {
        introducePlaceholder.text = "자기소개를 입력해주세요"
        introducePlaceholder.textColor = .heroGrayDA
        introducePlaceholder.font = .font15P
        self.view.addSubview(introducePlaceholder)
        
        introducePlaceholder.snp.makeConstraints { make in
            make.top.equalTo(introduceTextView.snp.top).offset(16)
            make.leading.equalTo(introduceTextView.snp.leading).offset(16)
        }
    }
    
    // MARK: IntroduceCountLabel
    func setupIntroduceCountLabel() {
        introduceCountLabel.text = "0/75"
        introduceCountLabel.textColor = .heroGrayA6A4A1
        introduceCountLabel.font = .font13P
        self.view.addSubview(introduceCountLabel)
        
        introduceCountLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceTextView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
}
