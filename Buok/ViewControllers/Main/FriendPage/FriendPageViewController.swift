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
    let backgroundHeaderBottomView = UIView()
    let bottomView = UIView()
    
//    private var buokmarks: [BuokmarkFlag] = [
//        BuokmarkFlag(date: "2021.03", title: "나홀로 북유럽\n배낭여행 떠나기", category: "ic_fill_travel"),
//        BuokmarkFlag(date: "2021.01", title: "취뽀 성공하기", category: "ic_fill_goal"),
//        BuokmarkFlag(date: "2020.12", title: "패러글라이딩 도전", category: "ic_fill_hobby"),
//        BuokmarkFlag(date: "2020.11", title: "교양학점 A이상 받기", category: "ic_fill_goal"),
//        BuokmarkFlag(date: "2020.09", title: "친구들과 일본여행가서\n초밥 먹기", category: "ic_fill_travel"),
//        BuokmarkFlag(date: "2020.08", title: "버킷리스트6", category: "ic_fill_want"),
//        BuokmarkFlag(date: "2020.06", title: "버킷리스트7", category: "ic_fill_volunteer"),
//        BuokmarkFlag(date: "2020.02", title: "버킷리스트8", category: "ic_fill_finance"),
//        BuokmarkFlag(date: "2019.08", title: "버킷리스트9", category: "ic_fill_health"),
//        BuokmarkFlag(date: "2019.05", title: "버킷리스트10", category: "ic_fill_etc")]
    private var buokmarks: [BuokmarkFlag] = []
    private var bucketbooks: [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupSafeAreaView()
        setupTopView()
        setupBackButton()
        
        setupCollectionView()
        setupProfileView()
        setupHeaderView()
        setupBackgroundHeaderBottomView()
        setupBottomView()
        
        self.view.bringSubviewToFront(safeAreaView)
        self.view.bringSubviewToFront(topView)
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
        if headerView.buokmarkButton.isSelected {
            return section == 0 ? buokmarks.count : 0
        } else {
            return section == 0 ? 0 : bucketbooks.count
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
        
        cell.setInformation(to: buokmarks[indexPath.row], color: MypageViewController.buokmarkColors[indexPath.row % 3])
        cell.backgroundColor = .heroPrimaryBeigeLighter
        
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
        
        backgroundHeaderBottomView.layer.transform = transform
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
        self.view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: HeaderView
    func setupHeaderView() {
        self.view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: BackgroundHeaderBottomView
    func setupBackgroundHeaderBottomView() {
        backgroundHeaderBottomView.backgroundColor = .heroPrimaryBeigeLighter
        self.view.addSubview(backgroundHeaderBottomView)
        
        backgroundHeaderBottomView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        self.view.sendSubviewToBack(backgroundHeaderBottomView)
    }
    
    // MARK: BottomView
    func setupBottomView() {
        bottomView.backgroundColor = .heroPrimaryBeigeLighter
        self.view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(self.headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.sendSubviewToBack(bottomView)
    }
}
