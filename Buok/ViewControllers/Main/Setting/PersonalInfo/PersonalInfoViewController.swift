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
    private let contentTextView: UITextView = UITextView()
    
    public var viewModel: PersonalInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.addSubview(topContentView)
        setupNavigationView()
        setupTextView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel?.personalInfoData.bind({ [weak self] content in
            guard let `self` = self else { return }
            self.contentTextView.text = content
        })
        
        viewModel?.getPersonalInfoData()
    }
    
    private func setupTextView() {
        view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentTextView.font = .font14P
        contentTextView.textColor = .heroGray5B
        contentTextView.backgroundColor = .clear
        contentTextView.showsVerticalScrollIndicator = false
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
