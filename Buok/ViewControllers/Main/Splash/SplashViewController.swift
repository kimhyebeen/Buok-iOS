//
//  SplashViewController.swift
//  Buok
//
//  Created by Taein Kim on 2021/05/29.
//

import Foundation
import HeroCommon
import HeroUI

final class SplashViewController: HeroBaseViewController {
    private let logoView: UIView = UIView()
    private let logoImageView: UIImageView = UIImageView()
    private var viewModel: SplashViewModel?
    
    init(viewModel: SplashViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        setObservable()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            DebugLog("Check RefreshToken")
            self.viewModel?.checkRefreshToken()
        })
    }
    
    private func setupViewLayout() {
        view.addSubview(logoView)
        logoView.addSubview(logoImageView)
        
        logoView.snp.makeConstraints { make in
            make.width.equalTo(208)
            make.height.equalTo(80)
            make.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
        view.backgroundColor = .heroGrayF2EDE8
        logoView.backgroundColor = .heroWhite100s
        logoView.layer.cornerRadius = 10
        logoImageView.image = UIImage(heroSharedNamed: "ic_logo_hori")
    }
    
    private func setObservable() {
        viewModel?.isValidToken.bind({ [weak self] isValid in
            if isValid {
                self?.viewModel?.goToHomeVC()
            } else {
                self?.viewModel?.goToLoginVC()
            }
        })
    }
}
