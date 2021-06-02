//
//  SearchViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/06/01.
//

import Foundation
import HeroCommon
import HeroUI

final class SearchViewController: HeroBaseViewController {
    public var viewModel: SearchViewModel?
    private let statusBarBackgroundView: UIView = UIView()
    private let searchContainerView: UIView = UIView()
    private let closeButton: UIButton = UIButton()
    private let searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(statusBarBackgroundView)
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(closeButton)
        searchContainerView.addSubview(searchBar)
        
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
            make.leading.equalToSuperview()
            make.trailing.equalTo(closeButton.snp.leading).offset(-16)
        }
        
        statusBarBackgroundView.backgroundColor = .heroWhite100s
        searchContainerView.backgroundColor = .heroWhite100s
        searchBar.backgroundImage = UIImage()
        
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.heroGray82, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        closeButton.addTarget(self, action: #selector(onClickClose(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
