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
    let contentsView = MypageContentsView()
    let buokmarkHeader = MypageBuokmarkHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupSettingButton()
        setupContentsView()
        setupBuokmarkHeader()
    }

    @objc
    func clickSettingButton(_ sender: UIButton) {
        // todo - 설정 버튼 기능
    }
    
}

extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightForSettingButton: CGFloat = 44
        let heightForProfileView: CGFloat = 284
        let heightForHeader: CGFloat = 40
        
        let totalOffset = scrollView.contentOffset.y + heightForSettingButton + heightForProfileView + heightForHeader
        let offsetForHeader = heightForSettingButton + heightForProfileView
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, max(-offsetForHeader, -totalOffset), 0)
        
        settingButton.layer.transform = transform
        contentsView.layer.transform = transform
        buokmarkHeader.layer.transform = transform
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 96)
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
        collectionView.contentInset = UIEdgeInsets(top: 368, left: 0, bottom: 0, right: 0)
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
    
    // MARK: ContentsView
    private func setupContentsView() {
        self.view.addSubview(contentsView)
        
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(settingButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: BuokmarkHeader
    private func setupBuokmarkHeader() {
        self.view.addSubview(buokmarkHeader)
        
        buokmarkHeader.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(contentsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
