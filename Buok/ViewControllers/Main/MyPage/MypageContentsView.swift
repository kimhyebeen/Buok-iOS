//
//  MypageContentsView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import UIKit

class MypageContentsView: UIView {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let modifyButton = UIButton()
    private let countingButtonStack = MypageCountingStackView()
    private let introduceLabel = UILabel()
    private let dateImageView = UIImageView()
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupProfileImageView()
        setupNameLabel()
        setupEmailLabel()
        setupModifyButton()
        setupCountingButtonStack()
        setupIntroduceLabel()
        setupDateImageView()
        setupDateLabel()
    }
    
    func setProfile() {
        // todo - Profile 객체를 받아 뷰 업데이트
    }

}

extension MypageContentsView {
    // MARK: ProfileImageView
    private func setupProfileImageView() {
        profileImageView.layer.cornerRadius = 32
        profileImageView.layer.backgroundColor = UIColor.white.cgColor
        self.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: NameLabel
    private func setupNameLabel() {
        nameLabel.text = "홍길동"
        nameLabel.textColor = .heroGray5B
        nameLabel.font = .font20PBold // todo - 폰트 수정 필요
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(7)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
    }
    
    // MARK: EmailLabel
    private func setupEmailLabel() {
        emailLabel.text = "gildong@naver.com"
        emailLabel.textColor = .heroGray82
        emailLabel.font = .font13P
        self.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
        }
    }
    
    // MARK: ModifyButton
    private func setupModifyButton() {
        modifyButton.setAttributedTitle(NSAttributedString(string: "프로필 수정", attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.heroGray82]), for: .normal)
        modifyButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        modifyButton.layer.cornerRadius = 8
        modifyButton.layer.borderWidth = 1
        modifyButton.layer.borderColor = UIColor.heroGray82.cgColor
        self.addSubview(modifyButton)
        
        modifyButton.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(36)
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: CountingButtonStack
    private func setupCountingButtonStack() {
        self.addSubview(countingButtonStack)
        
        countingButtonStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: IntroduceLabel
    private func setupIntroduceLabel() {
        introduceLabel.text = "안녕하세요.\n사용자 홍길동의 버킷 페이지입니다.\n75자까지 입력 가능, 3줄까지만 보여짐"
        introduceLabel.numberOfLines = 0
        introduceLabel.textColor = .heroGray82
        introduceLabel.font = .font13P
        self.addSubview(introduceLabel)
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(countingButtonStack.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(23)
        }
    }
    
    // MARK: DateImageView
    private func setupDateImageView() {
        if #available(iOS 13.0, *) {
            dateImageView.image = UIImage(heroSharedNamed: "ic_date")!.withTintColor(.heroGray82)
        } else {
            dateImageView.image = UIImage(heroSharedNamed: "ic_date")!
        }
        self.addSubview(dateImageView)
        
        dateImageView.snp.makeConstraints { make in
            make.width.equalTo(18)
            make.height.equalTo(18.75)
            make.top.equalTo(introduceLabel.snp.bottom).offset(18.25)
            make.bottom.equalToSuperview().offset(-27)
            make.leading.equalTo(introduceLabel.snp.leading)
        }
    }
    
    // MARK: DateLabel
    private func setupDateLabel() {
        dateLabel.text = "2021년 06월에 가입함"
        dateLabel.textColor = .heroGray82
        dateLabel.font = .font13P
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateImageView.snp.centerY)
            make.leading.equalTo(dateImageView.snp.trailing).offset(11)
        }
    }
}
