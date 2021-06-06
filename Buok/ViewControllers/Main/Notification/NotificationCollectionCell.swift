//
//  NotificationCollectionCell.swift
//  Buok
//
//  Created by 김보민 on 2021/06/06.
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class NotificationCollectionCell: UICollectionViewCell {
	static let identifier = "NotificationCollectionCell"
	private let titleLabel: UILabel = {
		$0.font = .font15PBold
		$0.textColor = .heroGray5B
		$0.numberOfLines = 1
		return $0
	}(UILabel())
	
	private let contentLabel: UILabel = {
		$0.font = .font15P
		$0.textColor = .heroGray82
		$0.numberOfLines = 2
		return $0
	}(UILabel())
	
	public var notificationTitle: String? {
		didSet {
			titleLabel.text = notificationTitle
		}
	}
	
	public var notificationContent: String? {
		didSet {
			contentLabel.text = notificationContent
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
		setupContentLayout()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func setupView() {
		self.layer.cornerRadius = 8
		self.layer.backgroundColor = UIColor.white.cgColor
	}
	
	private func setupContentLayout() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(contentLabel)
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(12)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().inset(16)
		}
		
		contentLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(4)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().inset(16)
			make.bottom.equalToSuperview().inset(12)
		}
	}
}
