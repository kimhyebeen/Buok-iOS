//
//  HomeViewController+UI.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

extension HomeViewController {
    func setupMainLayout() {
        view.addSubview(topContentView)
        view.addSubview(topSectionView)
        view.addSubview(bucketCollectionView)
        
        topContentView.addSubview(notiButton)
        topContentView.addSubview(searchButton)
        
        // Top Filter Section
        topSectionView.addArrangedSubview(filterContainerView)
        topSectionView.addArrangedSubview(messageContainerView)
        topSectionView.addArrangedSubview(totalContainerView)
        filterContainerView.addSubview(bucketFilterView)
        filterContainerView.addSubview(categoryContainerView)
        
        // Category Button
        categoryContainerView.addSubview(categoryTitleLabel)
        categoryContainerView.addSubview(categoryImageView)
        categoryContainerView.addSubview(categoryButton)
        categoryContainerView.bringSubviewToFront(categoryButton)
        
        categoryContainerView.addSubview(categoryDeleteButton)
        
        messageContainerView.addSubview(bubbleTriangleView)
        messageContainerView.addSubview(bucketCountBubble)
        bucketCountBubble.addSubview(countDescLabel)
        
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(48)
        }
        
        notiButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.centerY.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-7)
            make.centerY.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        // Top Filter Section
        topSectionView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        bucketFilterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Category Button
        categoryContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(categoryTitleLabel.snp.trailing).offset(2)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        categoryDeleteButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(categoryImageView.snp.leading)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // CollectionView
        bucketCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topSectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        setupBubbleLayout()
        setupTotalViewLayout()
    }
    
    func setupBubbleLayout() {
        bucketCountBubble.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        bubbleTriangleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(22.93)
            make.height.equalTo(19)
            make.bottom.equalTo(bucketCountBubble.snp.top).offset(3)
            make.leading.equalToSuperview().offset(13)
        }
        
        countDescLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        
        topSectionView.axis = .vertical
        messageContainerView.backgroundColor = .clear
        bucketFilterView.delegate = self
        
        bucketCountBubble.layer.cornerRadius = 7
        bucketCountBubble.backgroundColor = .heroPrimaryNavyLight
        bubbleTriangleView.image = UIImage(heroSharedNamed: "ic_bubble_triangle")
        
        countDescLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        countDescLabel.textColor = .heroWhite100s
        
        categoryContainerView.backgroundColor = .heroWhite100s
        categoryContainerView.layer.cornerRadius = 8
        
        categoryTitleLabel.text = "Hero_Common_Category".localized
        categoryTitleLabel.font = .font15P
        categoryTitleLabel.textColor = .heroGray82
        categoryButton.addTarget(self, action: #selector(onClickCategoryFilterButton(_:)), for: .touchUpInside)
        categoryImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
        
        categoryDeleteButton.isEnabled = false
        categoryDeleteButton.addTarget(self, action: #selector(onClickCategoryDeleteButton(_:)), for: .touchUpInside)
        
        totalLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        totalLabel.textColor = .heroGray82
        
        sortLabel.text = "작성순"
        sortLabel.textColor = .heroGray82
        sortLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        sortImageView.image = UIImage(heroSharedNamed: "ic_narrow_12")
        
        sortButton.addTarget(self, action: #selector(onClickSortButton(_:)), for: .touchUpInside)
        
        bucketCollectionView.delegate = self
        bucketCollectionView.dataSource = self
        bucketCollectionView.backgroundColor = .clear
        bucketCollectionView.showsVerticalScrollIndicator = false
        bucketCollectionView.register(BucketItemCell.self, forCellWithReuseIdentifier: BucketItemCell.identifier)
    }
    
    func setupTotalViewLayout() {
        totalContainerView.addSubview(totalLabel)
        totalContainerView.addSubview(sortContainerView)
        
        sortContainerView.addSubview(sortLabel)
        sortContainerView.addSubview(sortImageView)
        sortContainerView.addSubview(sortButton)
        
        totalContainerView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        sortContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        sortImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        sortLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(sortImageView.snp.leading).offset(-3)
        }
        
        sortButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.bucketCount.value ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BucketItemCell.identifier, for: indexPath) as? BucketItemCell else {
            return BucketItemCell()
        }
        
        cell.bucket = viewModel?.bucketList.value[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bucket = viewModel?.bucketList.value[indexPath.row]
        let vc = DetailViewController()
        let viewModel = DetailViewModel()
        viewModel.bucketItem.value = bucket
        vc.viewModel = viewModel
        vc.tabBarDelegate = tabBarDelegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Before : Collection View Frame Width
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width / 2 - 4, height: width / 2 - 9 + 16 + 2)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
