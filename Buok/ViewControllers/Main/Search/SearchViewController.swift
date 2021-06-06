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
    
    private let bucketCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let friendCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    public var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self?.viewModel?.fetchSearchResult(type: type, keyword: self?.viewModel?.searchKeyword.value ?? "")
        })
    }
    
    private func setupBucketCollectionView() {
        view.addSubview(bucketCollectionView)
        bucketCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterContainerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupFriendCollectionView() {
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
        
        setupBucketCollectionView()
        setupFriendCollectionView()
        
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
    }
    
    @objc
    private func onClickMyBook(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .myBucket
    }
    
    @objc
    private func onClickAccount(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .user
    }
    
    @objc
    private func onClickBookmark(_ sender: UIButton) {
        viewModel?.currentSearchType.value = .mark
    }
    
    @objc
    private func onClickClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let type = viewModel?.currentSearchType.value, let keyword = searchBar.text {
            viewModel?.fetchSearchResult(type: type, keyword: keyword)
        }
    }
}
