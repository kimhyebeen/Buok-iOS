//
//  FriendPageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/22.
//

import HeroUI

class FriendPageViewController: HeroBaseViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let safeAreaView = UIView()
    let topView = UIView()
    let backButton = UIButton()
    
    let profileView = FriendPageProfileView()
    let headerView = FriendPageBuokmarkHeaderView()
    let emptyBucketStackView = UIStackView()
    
    private var viewModel = FriendPageViewModel()

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
        setupEmptyBucketView()
        
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

extension FriendPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        cell.setInformation(to: viewModel.buokmarks[indexPath.row], color: MypageViewController.buokmarkColors[indexPath.row % 3])
        
        return cell
    }
    
    private func settingBucketBookCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
        let width = collectionView.frame.width
        if indexPath.section == 0 {
            return CGSize(width: width, height: 96)
        } else {
            return CGSize(width: width / 2 - 28, height: width / 2 - 28 + 16 + 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
    }
}

extension FriendPageViewController: FriendPageBuokmarkHeaderViewDelegate {
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

extension FriendPageViewController: FriendPageProfileViewDelegate {
    func onClickFriendButton() {
        // todo - 친구버튼 구현
    }
}

extension FriendPageViewController {
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
        collectionView.contentInset = UIEdgeInsets(top: 368 + 20, left: 0, bottom: 0, right: 0)
        collectionView.register(BuokmarkCollectionCell.self, forCellWithReuseIdentifier: BuokmarkCollectionCell.identifier)
        // todo - 버킷북 cell 등록
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
        self.view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: EmptyBucketImageView
    func setupEmptyBucketView() {
        let emptyBucketImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 143, height: 143))
        emptyBucketImageView.image = UIImage(heroSharedNamed: "ill_lock")
        emptyBucketImageView.contentMode = .scaleAspectFit
        emptyBucketStackView.addArrangedSubview(emptyBucketImageView)
        
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
        
        emptyBucketStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}
