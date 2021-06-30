//
//  PersonalInfoViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class PersonalInfoViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let backButton: HeroImageButton = HeroImageButton()
    
    public var viewModel: PersonalInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.addSubview(topContentView)
        setupNavigationView()
    }
    
    private func setupNavigationView() {
        topContentView.addSubview(titleLabel)
        topContentView.addSubview(backButton)
        topContentView.backgroundColor = .heroGrayF2EDE8
        topContentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        
        titleLabel.font = .font17PBold
        
        titleLabel.textColor = .heroGray82
        titleLabel.text = "개인정보보호정책"
        
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
