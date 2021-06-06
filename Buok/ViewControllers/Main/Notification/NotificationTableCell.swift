//
//  NotificationTableCell.swift
//  Buok
//
//  Created by 김보민 on 2021/06/06.
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroUI

class NotificationTableCell: UITableViewCell {
	static let identifier = "NotificationTableCell"
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
	private let mainContentView: UIView = {
		$0.backgroundColor = .white
		$0.layer.cornerRadius = 8
		return $0
	}(UIView())
	private let bottomView: UIView = {
		$0.backgroundColor = .heroServiceSkin
		return $0
	}(UIView())
	
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
	}
	
	private func setupContentLayout() {
		contentView.addSubview(mainContentView)
		mainContentView.addSubview(titleLabel)
		mainContentView.addSubview(contentLabel)
		contentView.addSubview(bottomView)
		
		mainContentView.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
		}
		
		bottomView.snp.makeConstraints { make in
			make.top.equalTo(mainContentView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(12)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(mainContentView.snp.top).offset(12)
			make.leading.equalTo(mainContentView.snp.leading).offset(16)
			make.trailing.equalTo(mainContentView.snp.trailing).inset(16)
		}
		
		contentLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(4)
			make.leading.equalTo(mainContentView.snp.leading).offset(16)
			make.trailing.equalTo(mainContentView.snp.trailing).inset(16)
			make.bottom.equalTo(mainContentView.snp.bottom).inset(12)
		}
	}
}
