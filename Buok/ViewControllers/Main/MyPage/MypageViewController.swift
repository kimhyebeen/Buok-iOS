//
//  MypageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import HeroUI

class MypageViewController: HeroBaseViewController {
    let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    let settingButton = UIButton()
    let profileView = MypageProfileView()
    let buokmarkHeader = MypageBuokmarkHeaderView()
    
    static let buokmarkColors: [UIColor] = [.heroPrimaryPinkLight, .heroPrimaryNavyLight, .heroPrimaryBlueLight]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupSettingButton()
        setupProfileView()
        setupBuokmarkHeader()
    }

    @objc
    func clickSettingButton(_ sender: UIButton) {
        // todo - 설정 버튼 기능
    }
    
    @objc
    func clickEditProfileButton(_ sender: UIButton) {
        // todo - 프로필 수정 버튼 기능
    }
    
    @objc
    func clickFriendButton(_ sender: UIButton) {
        // todo - 친구 카운팅 버튼 기능
    }
    
    @objc
    func clickBucketButton(_ sender: UIButton) {
        // todo - 버킷 카운팅 버튼 기능
    }
    
}

// MARK: +Delegate
extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuokmarkCollectionCell.identifier, for: indexPath) as? BuokmarkCollectionCell else { return BuokmarkCollectionCell() }
        
        let testFlags: [BuokmarkFlag] = [
            BuokmarkFlag(date: "2021.03", title: "나홀로 북유럽\n배낭여행 떠나기", category: "ic_fill_travel"),
            BuokmarkFlag(date: "2021.01", title: "취뽀 성공하기", category: "ic_fill_goal"),
            BuokmarkFlag(date: "2020.12", title: "패러글라이딩 도전", category: "ic_fill_hobby"),
            BuokmarkFlag(date: "2020.11", title: "교양학점 A이상 받기", category: "ic_fill_goal"),
            BuokmarkFlag(date: "2020.09", title: "친구들과 일본여행가서\n초밥 먹기", category: "ic_fill_travel"),
            BuokmarkFlag(date: "2020.08", title: "버킷리스트6", category: "ic_fill_want"),
            BuokmarkFlag(date: "2020.06", title: "버킷리스트7", category: "ic_fill_volunteer"),
            BuokmarkFlag(date: "2020.02", title: "버킷리스트8", category: "ic_fill_finance"),
            BuokmarkFlag(date: "2019.08", title: "버킷리스트9", category: "ic_fill_health"),
            BuokmarkFlag(date: "2019.05", title: "버킷리스트10", category: "ic_fill_etc")]
        
        cell.setInformation(to: testFlags[indexPath.row], color: MypageViewController.buokmarkColors[indexPath.row % 3])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightForSettingButton: CGFloat = 44
        let heightForProfileView: CGFloat = 284
        let heightForHeader: CGFloat = 40
        
        let totalOffset = scrollView.contentOffset.y + heightForSettingButton + heightForProfileView + heightForHeader + 20
        let offsetForHeader = heightForSettingButton + heightForProfileView
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, max(-offsetForHeader, -totalOffset), 0)
        
        settingButton.layer.transform = transform
        profileView.layer.transform = transform
        buokmarkHeader.layer.transform = transform
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MypageViewController {
    // MARK: CollectionView
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 368 + 20, left: 0, bottom: 0, right: 0)
        collectionView.register(BuokmarkCollectionCell.self, forCellWithReuseIdentifier: BuokmarkCollectionCell.identifier)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: SettingButton
    private func setupSettingButton() {
        if #available(iOS 13.0, *) {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!.withTintColor(.heroGray82), for: .normal)
        } else {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!, for: .normal)
        }
        settingButton.addTarget(self, action: #selector(clickSettingButton(_:)), for: .touchUpInside)
        self.view.addSubview(settingButton)
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: ProfileView
    private func setupProfileView() {
        profileView.editButton.addTarget(self, action: #selector(clickEditProfileButton(_:)), for: .touchUpInside)
        profileView.countingButtonStack.friendButton.addTarget(self, action: #selector(clickFriendButton(_:)), for: .touchUpInside)
        profileView.countingButtonStack.bucketButton.addTarget(self, action: #selector(clickBucketButton(_:)), for: .touchUpInside)
        self.view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: BuokmarkHeader
    private func setupBuokmarkHeader() {
        buokmarkHeader.count = 10
        buokmarkHeader.backgroundColor = .heroServiceSkin
        self.view.addSubview(buokmarkHeader)
        
        buokmarkHeader.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
