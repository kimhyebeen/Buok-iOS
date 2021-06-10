//
//  SearchViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class SearchViewController: HeroBaseViewController {
    private let statusBarBackgroundView: UIView = UIView()
    private let searchContainerView: UIView = UIView()
    private let closeButton: UIButton = UIButton()
    private let searchBar: UISearchBar = UISearchBar()
    
    private let filterContainerView: UIView = UIView()
    private let filterStackView: UIStackView = UIStackView()
    
    private let filterMyBookButton: UIButton = UIButton()
    private let filterAccountButton: UIButton = UIButton()
    private let filterBookmarkButton: UIButton = UIButton()
    
    private let filterMyBookBar: UIView = UIView()
    private let filterAccountBar: UIView = UIView()
    private let filterBookmarkBar: UIView = UIView()
    
    private let noSearchResults: UILabel = UILabel()

    private let bucketCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let friendCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    public var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViewProperties()
        setupViewLayout()
        bindViewModel()
        viewModel?.currentSearchType.value = .myBucket
    }
    
    private func bindViewModel() {
        viewModel?.currentSearchType.bind({ [weak self] type in
            self?.filterMyBookBar.isHidden = !(type == .myBucket)
            self?.filterAccountBar.isHidden = !(type == .user)
            self?.filterBookmarkBar.isHidden = !(type == .mark)
            
            self?.filterMyBookButton.setTitleColor((type == .myBucket ? .heroGray5B : .heroGray82), for: .normal)
            self?.filterAccountButton.setTitleColor((type == .user ? .heroGray5B : .heroGray82), for: .normal)
            self?.filterBookmarkButton.setTitleColor((type == .mark ? .heroGray5B : .heroGray82), for: .normal)
            
            self?.bucketCollectionView.isHidden = !(type == .mark || type == .myBucket)
            self?.friendCollectionView.isHidden = !(type == .user)
			
//			self?.bucketCollectionView.reloadData()
//			self?.friendCollectionView.reloadData()
        })
        
        viewModel?.bucketSearchList.bind({ [weak self] _ in
            self?.bucketCollectionView.reloadData()
        })
		
		viewModel?.bucketSearchCount.bind({ [weak self] _ in
			self?.bucketCollectionView.reloadData()
		})
		
//		viewModel?.isSearchedKeyword.bind({ [weak self] _ in
//			self?.viewModel?.fetchSearchResult(type: type, keyword: self?.viewModel?.searchKeyword.value ?? "")
//			self?.bucketCollectionView.reloadData()
//		})
    }
    
    private func setupBucketCollectionView() {
        bucketCollectionView.backgroundColor = .heroServiceSkin
        view.addSubview(bucketCollectionView)
        bucketCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(filterContainerView.snp.bottom).offset(22)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			make.top.equalTo(filterContainerView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupFriendCollectionView() {
        friendCollectionView.backgroundColor = .heroServiceSkin
        view.addSubview(friendCollectionView)
        friendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterContainerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupViewLayout() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(statusBarBackgroundView)
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(closeButton)
        searchContainerView.addSubview(searchBar)
        
        view.addSubview(filterContainerView)
        filterContainerView.addSubview(filterStackView)
        filterStackView.addArrangedSubview(filterMyBookButton)
        filterStackView.addArrangedSubview(filterAccountButton)
        filterStackView.addArrangedSubview(filterBookmarkButton)
        
        filterMyBookButton.addSubview(filterMyBookBar)
        filterAccountButton.addSubview(filterAccountBar)
        filterBookmarkButton.addSubview(filterBookmarkBar)
        
        setupBucketCollectionView()
        setupFriendCollectionView()
        view.addSubview(noSearchResults)
        
        statusBarBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        searchContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-19)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(closeButton.snp.leading).offset(-16)
        }
        
        filterContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchContainerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(41)
            make.trailing.equalToSuperview().offset(-41)
        }
        
        filterMyBookBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(72)
        }
        
        filterAccountBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(72)
        }
        
        filterBookmarkBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(72)
        }
        
        noSearchResults.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        statusBarBackgroundView.backgroundColor = .heroWhite100s
        searchContainerView.backgroundColor = .heroWhite100s
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.heroGray82, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        closeButton.addTarget(self, action: #selector(onClickClose(_:)), for: .touchUpInside)
        
        filterStackView.axis = .horizontal
        filterStackView.distribution = .equalSpacing
        filterMyBookButton.setTitle("마이북", for: .normal)
        filterAccountButton.setTitle("계정", for: .normal)
        filterBookmarkButton.setTitle("북마크", for: .normal)
        
        filterMyBookButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        filterAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        filterBookmarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        filterContainerView.backgroundColor = .heroWhite100s
        
        filterMyBookBar.backgroundColor = .heroGray5B
        filterAccountBar.backgroundColor = .heroGray5B
        filterBookmarkBar.backgroundColor = .heroGray5B
        
        filterMyBookButton.addTarget(self, action: #selector(onClickMyBook(_:)), for: .touchUpInside)
        filterAccountButton.addTarget(self, action: #selector(onClickAccount(_:)), for: .touchUpInside)
        filterBookmarkButton.addTarget(self, action: #selector(onClickBookmark(_:)), for: .touchUpInside)
        
        noSearchResults.text = "검색 결과가 없습니다."
        noSearchResults.font = .font17P
        noSearchResults.textColor = .heroGray5B
    }
    
    private func setupViewProperties() {
        bucketCollectionView.delegate = self
        bucketCollectionView.dataSource = self
        bucketCollectionView.backgroundColor = .clear
        bucketCollectionView.showsVerticalScrollIndicator = false
        bucketCollectionView.register(BucketItemCell.self, forCellWithReuseIdentifier: BucketItemCell.identifier)
    }
    
    @objc
    private func onClickMyBook(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .myBucket
		if viewModel?.isSearchedKeyword == true {
			viewModel?.fetchSearchResult(type: .myBucket, keyword: viewModel?.searchKeyword.value ?? "")
			self.bucketCollectionView.reloadData()
		}
    }
    
    @objc
    private func onClickAccount(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .user
		if viewModel?.isSearchedKeyword == true {
			viewModel?.fetchSearchResult(type: .user, keyword: viewModel?.searchKeyword.value ?? "")
			self.friendCollectionView.reloadData()
		}
    }
    
    @objc
    private func onClickBookmark(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .mark
		if viewModel?.isSearchedKeyword == true {
			viewModel?.fetchSearchResult(type: .mark, keyword: viewModel?.searchKeyword.value ?? "")
			self.bucketCollectionView.reloadData()
		}
    }
    
    @objc
    private func onClickClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let type = viewModel?.currentSearchType.value, let keyword = searchBar.text {
			if let viewModel = viewModel {
            viewModel.fetchSearchResult(type: type, keyword: keyword)
            noSearchResults.isHidden = true
			
			viewModel.isSearchedKeyword = true
			}
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.bucketSearchCount.value ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BucketItemCell.identifier, for: indexPath) as? BucketItemCell else {
            return BucketItemCell()
        }
		
		cell.bucketSearch = viewModel?.bucketSearchList.value[indexPath.row]
		
		return cell
	}
	
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let bucket = viewModel?.bucketSearchList.value[indexPath.row]
//        let vc = DetailViewController()
//        let viewModel = DetailViewModel()
//        viewModel.bucketItem.value = bucket
//        vc.viewModel = viewModel
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Before : Collection View Frame Width
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width / 2 - 9, height: width / 2 - 9 + 16 + 2)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}
