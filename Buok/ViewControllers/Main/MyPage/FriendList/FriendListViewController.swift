//
//  FriendListViewController.swift
//  Buok
//
//  Created by 김혜빈 on 2021/05/24.
//

import HeroUI

class FriendListViewController: HeroBaseViewController {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let viewModel = FriendListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupBackButton()
        setupTitleLabel()
        setupCollectionView()
    }
    
    @objc
    func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension FriendListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendListCollectionCell.identifier, for: indexPath) as? FriendListCollectionCell else {
            return FriendListCollectionCell()
        }
        
        // todo - cell 정보 적용
        cell.settingInformation(indexPath.row % 2 == 0 ? nil : "자기소개입니다.")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // todo - 해당친구의 정보를 띄운 친구페이지로 이동
        let profileVC = ProfileViewController()
        profileVC.isMyPage = false
        self.navigationController?.pushViewController(profileVC, animated: true)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FriendListViewController {
    // MARK: BackButton
    private func setupBackButton() {
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: TitleLabel
    private func setupTitleLabel() {
        titleLabel.text = "Hero_Friend_List_Title".localized
        titleLabel.textColor = .heroGray82
        titleLabel.font = .font17PBold
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    // MARK: CollectionView
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
        collectionView.register(FriendListCollectionCell.self, forCellWithReuseIdentifier: FriendListCollectionCell.identifier)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}
