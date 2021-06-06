//
//  NotificationFriendTableCell.swift
//  Buok
//
//  Created by 김보민 on 2021/06/06.
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class NotificationFriendTableCell: UITableViewCell {
	static let identifier = "NotificationFriendCollectionCell"
	private let profileImageView = UIImageView()
	private let mainContentView: UIView = {
		$0.backgroundColor = .white
		$0.layer.cornerRadius = 8
		return $0
	}(UIView())
	private let bottomView: UIView = {
		$0.backgroundColor = .heroServiceSkin
		return $0
	}(UIView())
	private let contentLabel: UILabel = {
		$0.font = .font15P
		$0.textColor = .heroGray5B
		$0.numberOfLines = 2
		return $0
	}(UILabel())
	private let acceptButton: UIButton = {
		$0.setTitle("수락", for: .normal)
		$0.setTitleColor(.white, for: .normal)
		$0.titleLabel?.font = .font15PMedium
		$0.backgroundColor = .heroPrimaryNavyLight
		$0.layer.cornerRadius = 8
		return $0
	}(UIButton())
	private let rejectButton: UIButton = {
		$0.setTitle("거절", for: .normal)
		$0.setTitleColor(.heroGray82, for: .normal)
		$0.titleLabel?.font = .font15PMedium
		$0.backgroundColor = .heroPrimaryBeigeDown
		$0.layer.cornerRadius = 8
		return $0
	}(UIButton())
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		setupContentLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		self.backgroundColor = .heroServiceSkin
		profileImageView.image = UIImage(heroSharedNamed: "ic_profile_48")
		profileImageView.contentMode = .scaleAspectFill
		profileImageView.layer.cornerRadius = 28
		profileImageView.clipsToBounds = true
	}
	
	private func setupContentLayout() {
		contentView.addSubview(mainContentView)
		contentView.addSubview(bottomView)
		mainContentView.addSubview(profileImageView)
		mainContentView.addSubview(contentLabel)
		mainContentView.addSubview(acceptButton)
		mainContentView.addSubview(rejectButton)
		
		mainContentView.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
		}
		
		bottomView.snp.makeConstraints { make in
			make.top.equalTo(mainContentView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(12)
		}
		
		profileImageView.snp.makeConstraints { make in
			make.width.height.equalTo(56)
			make.top.equalTo(mainContentView.snp.top).offset(14)
			make.leading.equalTo(mainContentView.snp.leading).offset(16)
		}
		
		contentLabel.snp.makeConstraints { make in
			make.top.equalTo(mainContentView.snp.top).offset(12)
			make.leading.equalTo(profileImageView.snp.trailing).offset(16)
			make.trailing.equalTo(mainContentView.snp.trailing).inset(16)
		}
		
		acceptButton.snp.makeConstraints { make in
			make.top.equalTo(contentLabel.snp.bottom).offset(7)
			make.leading.equalTo(contentLabel.snp.leading)
			make.bottom.equalTo(mainContentView.snp.bottom).inset(12)
			make.width.equalTo(112)
			make.height.equalTo(32)
		}
		
		rejectButton.snp.makeConstraints { make in
			make.top.equalTo(contentLabel.snp.bottom).offset(7)
			make.leading.equalTo(acceptButton.snp.trailing).offset(8)
			make.trailing.equalTo(contentLabel.snp.trailing)
			make.bottom.equalTo(mainContentView.snp.bottom).inset(12)
			make.width.equalTo(112)
			make.height.equalTo(32)
		}
	}
	
	func applyAttributedNicknameText(nickname: String) {
		let text = "\(nickname)님이 회원님과 친구가 되고 싶어 합니다."
		
		let attributedStr = NSMutableAttributedString(string: text)
		attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: (text as NSString).range(of: nickname))
		attributedStr.addAttribute(.foregroundColor, value: UIColor.heroGray5B, range: (text as NSString).range(of: nickname))
		contentLabel.attributedText = attributedStr
	}
}