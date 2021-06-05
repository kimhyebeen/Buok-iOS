//
//  ProfileViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/05.
//

import HeroUI

class ProfileViewController: HeroBaseViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let safeAreaView = UIView()
    let topView = UIView()
    let backButton = UIButton()
    
    let profileView = ProfileView()
    let headerView = ProfileBuokmarkHeaderView()
    let emptyBucketStackView = UIStackView()
    
    private var viewModel = ProfileViewModel()
    
    var isMyPage: Bool = false {
        didSet {
            viewModel.isMe.value = isMyPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindingViewModel()
    }
    
    private func setupView() {
        self.view.backgroundColor = .heroPrimaryBeigeLighter
        
        setupSafeAreaView()
        setupTopView()
        setupBackButton()
        
        setupCollectionView()
        setupProfileView()
        setupHeaderView()
        setupDisabledBucketView()
        
        self.view.bringSubviewToFront(safeAreaView)
        self.view.bringSubviewToFront(topView)
    }
    
    private func bindingViewModel() {
        viewModel.fetchFriendProfile().then { [weak self] profile in
            // todo - profileView에 적용
            self?.headerView.countOfBuokmark = profile.buokmarks.count
            self?.profileView.settingFriendButtonType(for: profile.type)
            self?.collectionView.reloadData()
        }
        
        viewModel.isMe.bind({ [weak self] isMe in
            self?.profileView.isMyPage = isMe
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
}

// MARK: +Delegate

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if headerView.isSelectBuokmarkButton {
            return countOfBuokmarkMode(for: section)
        } else {
            return countOfBucketBookMode(for: section)
        }
    }
    
    private func countOfBuokmarkMode(for section: Int) -> Int {
        emptyBucketStackView.isHidden = true
        return section == 0 ? viewModel.buokmarks.count : 0
    }
    
    private func countOfBucketBookMode(for section: Int) -> Int {
        if viewModel.friendType == .friend {
            emptyBucketStackView.isHidden = true
            return section == 0 ? 0 : viewModel.bucketBooks.count
        } else {
            emptyBucketStackView.isHidden = false
            return section == 0 ? 0 : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return settingBuokmarkCell(collectionView, indexPath)
        } else {
            return settingBucketBookCell(collectionView, indexPath)
        }
    }
    
    private func settingBuokmarkCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuokmarkCollectionCell.identifier, for: indexPath) as? BuokmarkCollectionCell else {
            return BuokmarkCollectionCell()
        }
        
        if viewModel.bookmarkData.value.count > indexPath.row {
            cell.setInformation(to: viewModel.bookmarkData.value[indexPath.row], color: MypageViewController.buokmarkColors[indexPath.row % 3])
        }
        
        return cell
    }
    
    private func settingBucketBookCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BucketCollectionCell.identifier, for: indexPath) as? BucketCollectionCell else {
            return BucketCollectionCell()
        }
        
        let types: [BucketStatusType] = [.inProgress, .expected, .fail, .done]
        cell.setInformation(viewModel.bucketBooks[indexPath.row], types[indexPath.row % 4])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightForSettingButton: CGFloat = 44
        let heightForProfileView: CGFloat = 284
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
        // 친구 수 클릭
        self.navigationController?.pushViewController(FriendListViewController(), animated: true)
    }
    
    func onClickBucketCountingButton() {
        // 버킷 수 클릭
    }
    
    func onClickFriendButton() {
        // 친구버튼 구현
    }
}

extension ProfileViewController {
    // MARK: SafeAreaView
    func setupSafeAreaView() {
        safeAreaView.backgroundColor = .heroServiceSkin
        self.view.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    // MARK: TopView
    func setupTopView() {
        topView.backgroundColor = .heroServiceSkin
        self.view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(safeAreaView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
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
    }
    
    // MARK: CollectionView
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 368 + 20, left: 20, bottom: 0, right: 20)
        collectionView.register(BuokmarkCollectionCell.self, forCellWithReuseIdentifier: BuokmarkCollectionCell.identifier)
        collectionView.register(BucketCollectionCell.self, forCellWithReuseIdentifier: BucketCollectionCell.identifier)
    }
    
    // MARK: ProfileView
    func setupProfileView() {
        profileView.delegate = self
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
}
