//
//  MypageContentsView.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import HeroUI
import Kingfisher

protocol MypageProfileViewDelegate: AnyObject {
    func onClickEditButton()
    func onClickFriendCountingButton()
    func onClickBucketCountingButton()
}

class MypageProfileView: UIView {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    let editButton = UIButton()
    let countingButtonStack = MypageCountingStackView()
    private let introduceLabel = UILabel()
    private let dateImageView = UIImageView()
    private let dateLabel = UILabel()
    
    weak var delegate: MypageProfileViewDelegate?

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
        setupEditButton()
        setupCountingButtonStack()
        setupIntroduceLabel()
        setupDateImageView()
        setupDateLabel()
    }
    
    func setProfile(myPageData: MyPageUserData) {
        // todo - Profile 객체를 받아 뷰 업데이트
        nameLabel.text = myPageData.user.nickname
        emailLabel.text = myPageData.user.email
        introduceLabel.text = myPageData.user.intro
        
        if let createdDate = myPageData.user.createdDate {
            let date = createdDate.convertToDate()
            let components = date.get(.month, .year)
            if let month = components.month, let year = components.year {
                let monthString = month < 10 ? "0\(month)" : "\(month)"
                dateLabel.text = "\(year)년 \(monthString)월에 가입함"
            }
        }
        
        if let profileURL = URL(string: myPageData.user.profileUrl ?? "") {
            self.profileImageView.kf.setImage(with: profileURL)
        }
        
        countingButtonStack.friendCount = myPageData.friendCount
        countingButtonStack.bucketCount = myPageData.bucketCount
    }
    
    @objc
    func clickEditButton(_ sender: UIButton) {
        delegate?.onClickEditButton()
    }
    
    @objc
    func clickFriendCountingButton(_ sender: UIButton) {
        delegate?.onClickFriendCountingButton()
    }
    
    @objc
    func clickBucketCountingButton(_ sender: UIButton) {
        delegate?.onClickBucketCountingButton()
    }
    
}

extension MypageProfileView {
    // MARK: ProfileImageView
    private func setupProfileImageView() {
        profileImageView.image = UIImage(heroSharedNamed: "ic_profile_48")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 32
        profileImageView.clipsToBounds = true
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
        nameLabel.text = ""
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
        emailLabel.text = ""
        emailLabel.textColor = .heroGray82
        emailLabel.font = .font13P
        self.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
        }
    }
    
    // MARK: EditButton
    private func setupEditButton() {
        editButton.setAttributedTitle(NSAttributedString(string: "프로필 수정", attributes: [.font: UIFont.font15P, .foregroundColor: UIColor.heroGray82]), for: .normal)
        editButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        editButton.layer.cornerRadius = 8
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.heroGray82.cgColor
        editButton.addTarget(self, action: #selector(clickEditButton(_:)), for: .touchUpInside)
        self.addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(36)
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: CountingButtonStack
    private func setupCountingButtonStack() {
        countingButtonStack.friendButton.addTarget(self, action: #selector(clickFriendCountingButton(_:)), for: .touchUpInside)
        countingButtonStack.bucketButton.addTarget(self, action: #selector(clickBucketCountingButton(_:)), for: .touchUpInside)
        self.addSubview(countingButtonStack)
        
        countingButtonStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: IntroduceLabel
    private func setupIntroduceLabel() {
        introduceLabel.text = ""
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
        dateLabel.text = ""
        dateLabel.textColor = .heroGray82
        dateLabel.font = .font13P
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateImageView.snp.centerY)
            make.leading.equalTo(dateImageView.snp.trailing).offset(11)
        }
    }
}
