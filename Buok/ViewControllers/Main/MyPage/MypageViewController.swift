//
//  MypageViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/11.
//

import HeroUI

class MypageViewController: HeroBaseViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let safeAreaFillView: UIView = UIView()
    let topNavBar: UIView = UIView()
    let settingButton = UIButton()
    
    let profileView = MypageProfileView()
    let buokmarkHeader = MypageBuokmarkHeaderView()
    
    static let buokmarkColors: [UIColor] = [.heroPrimaryPinkLight, .heroPrimaryNavyLight, .heroPrimaryBlueLight]
    
    private let viewModel = MypageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindingViewModel()
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .heroServiceSkin
        view.addSubview(safeAreaFillView)
        safeAreaFillView.backgroundColor = .heroServiceSkin
        safeAreaFillView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        setupSettingButton()
        setupCollectionView()
        setupProfileView()
        setupBuokmarkHeader()
        
        view.bringSubviewToFront(safeAreaFillView)
        view.bringSubviewToFront(topNavBar)
    }
    
    private func bindingViewModel() {
        viewModel.fetchBuokmarks().then { [weak self] values in
            self?.buokmarkHeader.count = values.count
            self?.collectionView.reloadSections(IndexSet(0...0))
        }
    }

    @objc
    func clickSettingButton(_ sender: UIButton) {
        // todo - 설정 버튼 기능
    }
    
}

// MARK: +Delegate
extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.buokmarks.count > 0 ? viewModel.buokmarks.count : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.buokmarks.count > 0 {
            return settingBuokmarkCell(collectionView, indexPath)
        } else { return settingEmptyCell(collectionView, indexPath) }
    }
    
    private func settingBuokmarkCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuokmarkCollectionCell.identifier, for: indexPath) as? BuokmarkCollectionCell else {
            return BuokmarkCollectionCell()
        }
        
        cell.setInformation(to: viewModel.buokmarks[indexPath.row], color: MypageViewController.buokmarkColors[indexPath.row % 3])
        
        return cell
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightForSettingButton: CGFloat = 44
        let heightForProfileView: CGFloat = 284
        let heightForHeader: CGFloat = 40
        
        let totalOffset = scrollView.contentOffset.y + heightForSettingButton + heightForProfileView + heightForHeader + 20
        let offsetForHeader = heightForProfileView
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, max(-offsetForHeader, -totalOffset), 0)
        
//        settingButton.layer.transform = transform
        profileView.layer.transform = transform
        buokmarkHeader.layer.transform = transform
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if viewModel.buokmarks.count > 0 || indexPath.row > 0 { return false }
        // todo - home > 완료 이동
        print("MypageViewController - shouldSelectItemAt - home의 완료로 이동")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MypageViewController: MypageProfileViewDelegate {
    func onClickEditButton() {
        let editVC = EditProfileViewController()
        editVC.modalPresentationStyle = .fullScreen
        self.present(editVC, animated: true, completion: nil)
    }
    
    func onClickFriendCountingButton() {
        self.navigationController?.pushViewController(FriendListViewController(), animated: true)
    }
    
    func onClickBucketCountingButton() {
        // todo - 홈 화면 > 완료 화면으로 가기
    }    
}

extension MypageViewController {
    // MARK: CollectionView
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 368 + 20, left: 20, bottom: 0, right: 20)
        collectionView.register(BuokmarkCollectionCell.self, forCellWithReuseIdentifier: BuokmarkCollectionCell.identifier)
        collectionView.register(BuokmarkEmptyCollectionCell.self, forCellWithReuseIdentifier: BuokmarkEmptyCollectionCell.identifier)
    }
    
    // MARK: SettingButton
    private func setupSettingButton() {
        view.addSubview(topNavBar)
        topNavBar.backgroundColor = .heroServiceSkin
        topNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview()
        }
        
        if #available(iOS 13.0, *) {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!.withTintColor(.heroGray82), for: .normal)
        } else {
            settingButton.setImage(UIImage(heroSharedNamed: "ic_setting")!, for: .normal)
        }
        settingButton.addTarget(self, action: #selector(clickSettingButton(_:)), for: .touchUpInside)
        topNavBar.addSubview(settingButton)
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: ProfileView
    private func setupProfileView() {
        profileView.delegate = self
        self.view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(topNavBar.snp.bottom)
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
