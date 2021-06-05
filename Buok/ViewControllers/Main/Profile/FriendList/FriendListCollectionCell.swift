//
//  FriendListCollectionCell.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class FriendListCollectionCell: UICollectionViewCell {
    static let identifier = "FriendListCollectionCell"
    private let profileImageView = UIImageView()
    private let userLabel = UILabel()
    private let introLabel = UILabel()
    private let friendButton = FriendButton()
    
    private var topOfUserLabel: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupProfileImageVIew()
        setupUserLabel()
        setupIntroLabel()
        setupFriendButton()
    }
    
    func settingInformation(_ intro: String? = nil) {
        // todo - 친구 프로필, 계정이름, 자기소개 전달받기
        if let introduce = intro {
            introLabel.isHidden = false
            introLabel.text = introduce
            topOfUserLabel?.constant = 6
        } else {
            introLabel.isHidden = true
            topOfUserLabel?.constant = 16
        }
    }
    
    @objc
    func clickFriendButton(_ sender: UIButton) {
        // todo - 친구 취소 성공하면..
        friendButton.settingFriendButtonType(for: .none)
    }
}

extension FriendListCollectionCell {
    // MARK: ProfileImageView
    private func setupProfileImageVIew() {
        profileImageView.layer.cornerRadius = 24
        profileImageView.image = UIImage(heroSharedNamed: "ic_profile_48")
        self.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: UserLabel
    private func setupUserLabel() {
        userLabel.text = "Hero_Profile_Name_Sample".localized
        userLabel.textColor = .heroGray5B
        userLabel.font = .font15P
        self.addSubview(userLabel)
        
        userLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        topOfUserLabel = userLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor)
        topOfUserLabel?.constant = 6
        topOfUserLabel?.isActive = true
    }
    
    // MARK: IntroLabel
    private func setupIntroLabel() {
        introLabel.text = ""
        introLabel.textColor = .heroGray5B
        introLabel.font = .font12P
        self.addSubview(introLabel)
        
        introLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-6)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
    }
    
    // MARK: FriendButton
    private func setupFriendButton() {
        friendButton.settingFriendButtonType(for: .friend)
        friendButton.addTarget(self, action: #selector(clickFriendButton(_:)), for: .touchUpInside)
        self.addSubview(friendButton)
        
        friendButton.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
