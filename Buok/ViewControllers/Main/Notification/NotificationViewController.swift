//
//  NotificationViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class NotificationViewController: HeroBaseViewController {
	private let topContentView: UIView = UIView()
	private let titleLabel: UILabel = UILabel()
	private let backButton: HeroImageButton = HeroImageButton()
	
	let notificationCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
    public var viewModel: NotificationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		bindViewModel()
		setupViewLayout()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel?.fetchNotificationList()
	}
	
	func bindViewModel() {
		if let viewModel = viewModel {
			viewModel.notificationList.bind({ [weak self] _ in
				self?.notificationCollectionView.reloadData()
			})
		}
	}
	
	private func setupViewLayout() {
		view.addSubview(topContentView)
		view.addSubview(notificationCollectionView)
		setupNavigationView()
		setupContentLayout()
		setupViewProperties()
	}
	
	private func setupNavigationView() {
		topContentView.addSubview(titleLabel)
		topContentView.addSubview(backButton)
		topContentView.backgroundColor = .heroGrayF2EDE8
		topContentView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.height.equalTo(48)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		backButton.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.centerY.equalToSuperview()
			make.width.equalTo(48)
			make.height.equalTo(48)
		}
		
		titleLabel.font = .font17PMedium
		
		titleLabel.textColor = .heroGray82
		titleLabel.text = "알림"
		
		backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
		backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
	}
	
	private func setupContentLayout() {
		notificationCollectionView.snp.makeConstraints { make in
			make.top.equalTo(topContentView.snp.bottom).offset(8)
			make.leading.equalToSuperview().offset(20)
			make.trailing.equalToSuperview().offset(-20)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
	private func setupViewProperties() {
		notificationCollectionView.delegate = self
		notificationCollectionView.dataSource = self
		notificationCollectionView.backgroundColor = .clear
		notificationCollectionView.showsVerticalScrollIndicator = false
		notificationCollectionView.register(NotificationCollectionCell.self, forCellWithReuseIdentifier: NotificationCollectionCell.identifier)
		notificationCollectionView.register(NotificationFriendCollectionCell.self, forCellWithReuseIdentifier: NotificationFriendCollectionCell.identifier)
	}
	
	@objc
	private func onClickBackButton(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
	}
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.notificationCount.value ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if viewModel?.notificationList.value[indexPath.row].type == "normal" {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionCell.identifier, for: indexPath) as? NotificationCollectionCell else {
				return NotificationCollectionCell()
			}
	
			cell.notificationTitle = viewModel?.notificationList.value[indexPath.row].title
			cell.notificationContent = viewModel?.notificationList.value[indexPath.row].content
			
			return cell
		} else {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationFriendCollectionCell.identifier, for: indexPath) as? NotificationFriendCollectionCell else {
				return NotificationFriendCollectionCell()
			}
			
			cell.applyAttributedNicknameText(nickname: viewModel?.notificationList.value[indexPath.row].nickname ?? "")
			
			return cell
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 12
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var height: CGFloat = 0
		if viewModel?.notificationList.value[indexPath.row].type == "normal" {
			height = 88
		} else {
			height = 103
		}
		return CGSize(width: self.view.frame.width - 40, height: height)
	}
}
