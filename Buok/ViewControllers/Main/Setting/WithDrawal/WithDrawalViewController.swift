//
//  WithDrawalViewController.swift
//  Buok
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import HeroUI

final class WithDrawalViewController: HeroBaseViewController {
    private let topContentView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let backButton: HeroImageButton = HeroImageButton()
    
    private var contentTitleLabel: UILabel = {
        $0.text = "buok을 탈퇴하면,"
        $0.font = .font17PBold
        $0.textColor = .heroGray82
        return $0
    }(UILabel())
    
    private var contentLabel: UILabel = {
        $0.text = "buok에 작성된 모든 버킷북이 즉시 삭제 됩니다.\n모든 정보는 buok에 재가입해도 복구 불가능합니다.\n중요한 정보는 탈퇴 전에 진행해주세요."
        $0.font = .font15P
        $0.textColor = .heroGray82
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var confirmLabel: UILabel = {
        $0.text = "buok을 탈퇴하시겠습니까?"
        $0.font = .font17PBold
        $0.textColor = .heroGray5B
        return $0
    }(UILabel())
    
    private var withDrawalButton: UIButton = {
        $0.backgroundColor = .heroPrimaryNavyLight
        $0.layer.cornerRadius = 8
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(.heroWhite100s, for: .normal)
        $0.titleLabel?.font = .font17P
        return $0
    }(UIButton())
    
    public var viewModel: WithDrawalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.addSubview(topContentView)
        setupNavigationView()
        setupContentLayout()
    }
    
    private func setupContentLayout() {
        view.addSubview(contentTitleLabel)
        view.addSubview(contentLabel)
        view.addSubview(confirmLabel)
        view.addSubview(withDrawalButton)
        
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        confirmLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        withDrawalButton.snp.makeConstraints { make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
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
        titleLabel.text = "탈퇴"
        
        backButton.setImage(UIImage(heroSharedNamed: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
        withDrawalButton.addTarget(self, action: #selector(onClickWithDrawalButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickWithDrawalButton(_ sender: UIButton) {
        viewModel?.requestWithDrawal()
    }
    
    @objc
    private func onClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
