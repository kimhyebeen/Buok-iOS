//
//  ProfileViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import HeroCommon
import HeroUI

class ProfileViewController: HeroBaseViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let topView = UIView()
    let backButton = UIButton()
    let settingButton = UIButton()
    
    let profileView = ProfileView()
    let headerView = ProfileBuokmarkHeaderView()
    let emptyBucketStackView = UIStackView()
    let safeAreaFillView: UIView = UIView()
    
    static let buokmarkColors: [UIColor] = [.heroPrimaryPinkLight, .heroPrimaryNavyLight, .heroPrimaryBlueLight]
    
    var viewModel: ProfileViewModel?
    
    var isMyPage: Bool = false {
        didSet {
            viewModel?.isMe.value = isMyPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isMyPage {
            viewModel?.fetchMyPageInfo()
        } else {
            viewModel?.fetchProfileUserInfo()
        }
    }
    
    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = isMyPage ? .heroGrayF2EDE8 : .heroPrimaryBeigeLighter
        
        setupSafeAreaFillView()
        setupTopView()
        setupBackButton()
        setupCollectionView()
        setupProfileView()
        setupHeaderView()
        setupDisabledBucketView()
        self.view.bringSubviewToFront(topView)
        self.view.bringSubviewToFront(safeAreaFillView)
    }
    
    private func bindingViewModel() {
//        viewModel.().then { [weak self] profile in
//            // todo - profileView에 적용
//            self?.headerView.countOfBuokmark = profile.buokmarks.count
//            self?.profileView.settingFriendButtonType(for: profile.type)
//            self?.collectionView.reloadData()
//        }
        
        viewModel?.bookmarkCount.bind({ [weak self] count in
            self?.headerView.countOfBuokmark = count
            self?.collectionView.reloadData()
        })
        
        viewModel?.bookmarkData.bind({ [weak self] _ in
            self?.collectionView.reloadData()
        })
        
        viewModel?.bucketBookCount.bind({ [weak self] count in
            self?.collectionView.reloadData()
            self?.headerView.countOfBucket = count
        })
        
        viewModel?.bucketBookData.bind({ [weak self] _ in
            self?.collectionView.reloadData()
        })
        
        viewModel?.myUserData.bind({ [weak self] user in
            if let strongUser = user {
                self?.profileView.setProfile(myPageData: strongUser)
            }
        })
        
        viewModel?.userData.bind({ [weak self] user in
            if let strongUser = user {
                self?.profileView.setProfile(userData: strongUser)
            }
        })
        
        viewModel?.isMe.bind({ [weak self] isMe in
            self?.profileView.isMyPage = isMe
            self?.backButton.isHidden = isMe
            self?.settingButton.isHidden = !isMe
        })
		
		viewModel?.isFriendStatus.bind({ [weak self] status in
			self?.profileView.isFriendStatus = status
		})
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickFriendButton(_ sender: UIButton) {
        // todo - 친구 요청 버튼 기능
    }
    
    @objc
    func clickSettingButton(_ sender: UIButton) {
        // todo - 설정 버튼 기능
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
}

// MARK: +Delegate

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isMyPage ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMyPage {
            emptyBucketStackView.isHidden = true
            if let count = viewModel?.bookmarkCount.value {
                return count > 0 ? count : 3
            } else {
                return 0
            }
        } else {
            if headerView.isSelectBuokmarkButton {
                return countOfBuokmarkMode(for: section)
            } else {
                return countOfBucketBookMode(for: section)
            }
        }
    }
    
    private func countOfBuokmarkMode(for section: Int) -> Int {
        emptyBucketStackView.isHidden = true
        return section == 0 ? viewModel?.bookmarkData.value.count ?? 0 : 0
    }
    
    private func countOfBucketBookMode(for section: Int) -> Int {
        if viewModel?.friendType == .friend {
            emptyBucketStackView.isHidden = true
            return section == 0 ? 0 : viewModel?.bucketBookData.value.count ?? 0
        } else {
            emptyBucketStackView.isHidden = false
            return section == 0 ? 0 : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isMyPage {
            if viewModel?.bookmarkCount.value ?? 0 < 1 {
                return settingEmptyCell(collectionView, indexPath)
            } else {
                return settingBuokmarkCell(collectionView, indexPath)
            }
        } else {
            if indexPath.section == 0 {
                return settingBuokmarkCell(collectionView, indexPath)
            } else {
                return settingBucketBookCell(collectionView, indexPath)
            }
        }
    }
    
    private func settingEmptyCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuokmarkEmptyCollectionCell.identifier, for: indexPath) as? BuokmarkEmptyCollectionCell else {
            return BuokmarkEmptyCollectionCell()
        }
        
        if indexPath.row == 0 {
            cell.isFirst = true
        } else { cell.isFirst = false }
        
        return cell
    }
    
    private func settingBuokmarkCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuokmarkCollectionCell.identifier, for: indexPath) as? BuokmarkCollectionCell else {
            return BuokmarkCollectionCell()
        }
        
        if viewModel?.bookmarkData.value.count ?? 0 > indexPath.row {
            if let strongViewModel = viewModel {
                cell.setInformation(to: strongViewModel.bookmarkData.value[indexPath.row], color: ProfileViewController.buokmarkColors[indexPath.row % 3])
            }
        }
        
        return cell
    }
    
    private func settingBucketBookCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BucketCollectionCell.identifier, for: indexPath) as? BucketCollectionCell else {
            return BucketCollectionCell()
        }
        
        let types: [BucketStatusType] = [.inProgress, .expected, .fail, .done]
        if let strongViewModel = viewModel {
            cell.setInformation(strongViewModel.bucketBooks[indexPath.row], types[indexPath.row % 4])
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightForSettingButton: CGFloat = 44
        let heightForProfileView: CGFloat = profileView.frame.height // 284
        let heightForHeader: CGFloat = 40
        let heightForBackgroundHeaderBottomView: CGFloat = 20
        
        let totalOffset = scrollView.contentOffset.y + heightForSettingButton + heightForProfileView + heightForHeader + heightForBackgroundHeaderBottomView
        let offsetForHeader = heightForProfileView
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, max(-offsetForHeader, -totalOffset), 0)
        
        profileView.layer.transform = transform
        headerView.layer.transform = transform
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // todo - 클릭 처리
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40
        if indexPath.section == 0 {
            return CGSize(width: width, height: 96)
        } else {
            return CGSize(width: width / 2 - 9, height: width / 2 - 9 + 16 + 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 18
    }
}

extension ProfileViewController: ProfileBuokmarkHeaderViewDelegate {
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func onClickEditButton() {
        let editVC = EditProfileViewController()
        editVC.modalPresentationStyle = .fullScreen
        self.present(editVC, animated: true, completion: nil)
    }
    
    func onClickFriendCountingButton() {
        let vc = FriendListViewController()
		let viewModel = FriendListViewModel(userId: self.viewModel?.userId ?? 0)
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onClickBucketCountingButton() {
        // 버킷 수 클릭
    }
    
    func onClickFriendButton() {
		let userId = viewModel?.userData.value?.user.id ?? 0
		if viewModel?.isFriendStatus.value == FriendButtonType.none {
			viewModel?.requestFriend(friendId: userId)
		} else {
			viewModel?.deleteFriend(friendId: userId)
		}
    }
}

extension ProfileViewController {
    func setupSafeAreaFillView() {
        view.addSubview(safeAreaFillView)
        safeAreaFillView.backgroundColor = .heroServiceSkin
        safeAreaFillView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: TopView
    func setupTopView() {
        topView.backgroundColor = .heroServiceSkin
        self.view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(safeAreaFillView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        topView.addSubview(settingButton)
        if #available(iOS 13.0, *) {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!.withTintColor(.heroGray82), for: .normal)
        } else {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!, for: .normal)
        }
        settingButton.addTarget(self, action: #selector(clickSettingButton(_:)), for: .touchUpInside)
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
        
        settingButton.isHidden = !isMyPage
    }
    
    // MARK: BackButton
    func setupBackButton() {
        if #available(iOS 13.0, *) {
            backButton.setImage(UIImage(heroSharedNamed: "ic_back")?.withTintColor(.heroGray82), for: .normal)
        } else {
            backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.topView.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.bottom.leading.equalToSuperview()
        }
        
        backButton.isHidden = isMyPage
    }
    
    // MARK: CollectionView
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .heroServiceSkin
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 368 + 20, left: 20, bottom: 0, right: 20)
        collectionView.register(BuokmarkCollectionCell.self, forCellWithReuseIdentifier: BuokmarkCollectionCell.identifier)
        collectionView.register(BucketCollectionCell.self, forCellWithReuseIdentifier: BucketCollectionCell.identifier)
        collectionView.register(BuokmarkEmptyCollectionCell.self, forCellWithReuseIdentifier: BuokmarkEmptyCollectionCell.identifier)
    }
    
    // MARK: ProfileView
    func setupProfileView() {
        profileView.delegate = self
        profileView.isMyPage = isMyPage
        self.view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: HeaderView
    func setupHeaderView() {
        headerView.delegate = self
        headerView.isMyPage = isMyPage
        self.view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: DisabledBucketImageView
    func setupDisabledBucketView() {
        let disabledBucketImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 143, height: 143))
        disabledBucketImageView.image = UIImage(heroSharedNamed: "ill_lock")
        disabledBucketImageView.contentMode = .scaleAspectFit
        emptyBucketStackView.addArrangedSubview(disabledBucketImageView)
        
        let emptyBucketLabel = UILabel()
        emptyBucketLabel.numberOfLines = 0
        emptyBucketLabel.textAlignment = .center
        emptyBucketLabel.text = "Hero_Profile_Empty_Bucket".localized
        emptyBucketLabel.textColor = .heroGrayA6A4A1
        emptyBucketLabel.font = .font13P
        emptyBucketStackView.addArrangedSubview(emptyBucketLabel)
        
        emptyBucketStackView.axis = .vertical
        emptyBucketStackView.spacing = 8
        self.view.addSubview(emptyBucketStackView)
        
        let heightOfUntilHeaderView: CGFloat = 456
        let heightOfBottom = self.view.frame.maxY - heightOfUntilHeaderView
        emptyBucketStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset((heightOfBottom - 143) / 2)
            make.centerX.equalToSuperview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        DebugLog("Profile View Frame Height : \(profileView.frame.height)")
        collectionView.contentInset = UIEdgeInsets(top: 108 + profileView.frame.height, left: 20, bottom: 0, right: 20)
    }
    
    override func viewDidLayoutSubviews() {
        DebugLog("Profile View Frame Height : \(profileView.frame.height)")
        collectionView.contentInset = UIEdgeInsets(top: 108 + profileView.frame.height, left: 20, bottom: 0, right: 20)
    }
}
