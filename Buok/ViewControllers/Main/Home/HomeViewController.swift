//
//  HomeViewController.swift
//  Nadam
//
//  Created by Taein Kim on 2021/03/18.
//

import Foundation
import HeroCommon
import HeroSharedAssets
import HeroUI

public class HomeViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let notiButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_noti")
        $0.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    private let searchButton: HeroImageButton = {
        $0.imageInset = 8
        $0.heroImage = UIImage(heroSharedNamed: "ic_search")
        $0.addTarget(self, action: #selector(onClickSearch(_:)), for: .touchUpInside)
        return $0
    }(HeroImageButton())
    
    private let topSectionView: UIStackView = UIStackView()
    private let filterContainerView: UIView = UIView()
    private let messageContainerView: UIView = UIView()
    private let bucketFilterView: BucketFilterView = BucketFilterView()
    
    private var currentFilter: HomeFilter = .now
    public var viewModel: HomeViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        bindViewModel()
        
        let beforeTimeMillis = CFAbsoluteTimeGetCurrent()
        setupMainLayout()
        setupViewProperties()
        
        let afterTimeMillis = CFAbsoluteTimeGetCurrent()
        let elapsedTime = afterTimeMillis - beforeTimeMillis
        DebugLog("View Configuration Elapsed Time : \(elapsedTime)")
		
		notiButton.addTarget(self, action: #selector(onClickNotification(_:)), for: .touchUpInside)
        
        // MARK: TEST
        testFunction()
    }
    
    private func testFunction() {
        let accessResult = TokenManager.shared.setAccessToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMiIsImV4cCI6MTYyNDA2NjE2NX0.s3udBmY0_NGz1d2P_HR0OedOzaDoCNuuF16OEyuRjng")
        let refreshResult = TokenManager.shared.setRefreshToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMiIsImV4cCI6MTYyNDg1ODE2NX0.XKbMinwkmo7MeJId5FVawo8qiS4Csk1LoCQBd0N5-yk")
        
        let accessExpiredAtResult = TokenManager.shared.setAccessTokenExpiredDate(expiredAt: "2021-06-19 10:29:25".convertToDate())
        let refreshExpiredAtResult = TokenManager.shared.setRefreshTokenExpiredDate(expiredAt: "2021-06-28 14:29:25".convertToDate())
        
        DebugLog("Set Access Token Result : \(accessResult)")
        DebugLog("Set Refresh Token Result : \(refreshResult)")
        DebugLog("--------")
        
        DebugLog("Set Access Token ExpiredAt Result : \(accessExpiredAtResult)")
        DebugLog("Set Refresh Token ExpiredAt Result : \(refreshExpiredAtResult)")
        DebugLog("--------")
        
        DebugLog("Get Access Token Result : \(TokenManager.shared.getAccessToken() ?? "nil")")
        DebugLog("Get Refresh Token Result : \(TokenManager.shared.getRefreshToken() ?? "nil")")
        
        DebugLog("AccessToken Expired : \(TokenManager.shared.checkAccessTokenExpired())")
        DebugLog("RefreshToken Expired : \(TokenManager.shared.checkRefreshTokenExpired())")
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.helloText.bind({ helloText in
                self.asyncFunction(task: { function in
                    function(helloText)
                }, execute: { text in
                    DebugLog(text)
                })
            })
        }
    }
    
    private func setupMainLayout() {
        view.addSubview(topContentView)
        view.addSubview(topSectionView)
        topContentView.addSubview(notiButton)
        topContentView.addSubview(searchButton)
        
        // Top Filter Section
        topSectionView.addArrangedSubview(filterContainerView)
        topSectionView.addArrangedSubview(messageContainerView)
        filterContainerView.addSubview(bucketFilterView)
        
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
            make.height.equalTo(44)
        }
        
        bucketFilterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messageContainerView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .heroGrayF2EDE8
        
        topSectionView.axis = .vertical
        messageContainerView.backgroundColor = .heroWhite100s
        bucketFilterView.delegate = self
    }
    
    @objc
    private func onClickNotification(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
    
    @objc
    private func onClickSearch(_ sender: Any?) {
        navigationController?.pushViewController(MultiLevelViewController(), animated: true)
    }
    
    // MARK: Sample General Async Function
    private func asyncFunction<T>(task: @escaping ((@escaping (T) -> Void) -> Void),
                                  execute: @escaping (T) -> Void) {
        DispatchQueue.main.async {
            task(execute)
        }
    }
}

extension HomeViewController: BucketFilterDelegate {
    func filterChanged(filter to: HomeFilter) {
        if currentFilter != to {
            currentFilter = to
            viewModel?.filterChanged(filter: to)
        }
    }
}
