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
	private let tableView: UITableView = UITableView()
	
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
				self?.tableView.reloadData()
			})
		}
	}
	
	private func setupViewLayout() {
		view.addSubview(topContentView)
		view.addSubview(tableView)
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
		tableView.snp.makeConstraints { make in
			make.top.equalTo(topContentView.snp.bottom).offset(8)
			make.leading.equalToSuperview().offset(20)
			make.trailing.equalToSuperview().offset(-20)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
	private func setupViewProperties() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorInset = .zero
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = false
		
		tableView.register(NotificationTableCell.self, forCellReuseIdentifier: NotificationTableCell.identifier)
		tableView.register(NotificationFriendTableCell.self, forCellReuseIdentifier: NotificationFriendTableCell.identifier)
	}
	
	@objc
	private func onClickBackButton(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.notificationCount.value ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if viewModel?.notificationList.value[indexPath.row].type == "normal" {
			if let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableCell.identifier, for: indexPath) as? NotificationTableCell {
				
				cell.notificationTitle = viewModel?.notificationList.value[indexPath.row].title
				cell.notificationContent = viewModel?.notificationList.value[indexPath.row].content
				cell.selectionStyle = .none
				
				return cell
			}
		} else {
			if let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFriendTableCell.identifier, for: indexPath) as? NotificationFriendTableCell {
				
				cell.applyAttributedNicknameText(nickname: viewModel?.notificationList.value[indexPath.row].nickname ?? "")
				cell.selectionStyle = .none
				
				return cell
			}
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		var height: CGFloat = 0
		if viewModel?.notificationList.value[indexPath.row].type == "normal" {
			height = 100
		} else {
			height = 115
		}
		return height
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let shareAction = UIContextualAction(style: .normal, title: "삭제") { _, _, completion  in
			completion(true)
		}
		shareAction.backgroundColor = .heroServiceSkin
		let configuration = UISwipeActionsConfiguration(actions: [shareAction])
		return configuration
	}
}
