//
//  HeroAlertController.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public enum AlertTitleType {
    case full
    case titleOnly
    case descOnly
}

public enum AlertButtonType {
    case okCancel
    case yesNo
}

public class HeroAlertController: UIViewController {
    private let alertContentView: UIView = UIView()
    private let contentStackView: UIStackView = UIStackView()
    private let topButton: HeroAlertButton = HeroAlertButton()
    private let bottomButton: HeroAlertButton = HeroAlertButton()
    
    private let titleLabel: UILabel = UILabel()
    private let descLabel: UILabel = UILabel()
    
    public var buttonType: AlertButtonType = .okCancel {
        didSet {
            updateButtonTitle()
        }
    }
    
    public var titleType: AlertTitleType = .full {
        didSet {
            updateTitleViewHidden()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupMainLayout()
        setupViewProperties()
        updateTitleViewHidden()
        updateButtonTitle()
    }
    
    private func updateButtonTitle() {
        switch buttonType {
        case .okCancel:
            topButton.title = "확인"
            bottomButton.title = "취소"
        case .yesNo:
            topButton.title = "예"
            bottomButton.title = "아니오"
        }
    }
    
    private func updateTitleViewHidden() {
        switch titleType {
        case .full:
            titleLabel.isHidden = false
            descLabel.isHidden = false
        case .titleOnly:
            titleLabel.isHidden = false
            descLabel.isHidden = true
        case .descOnly:
            titleLabel.isHidden = true
            descLabel.isHidden = false
        }
    }
    
    private func setupMainLayout() {
        view.backgroundColor = .heroGray100a
        view.addSubview(alertContentView)
        
        alertContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        alertContentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descLabel)
        contentStackView.addArrangedSubview(topButton)
        contentStackView.addArrangedSubview(bottomButton)
        
        contentStackView.setCustomSpacing(8, after: titleLabel)
        contentStackView.setCustomSpacing(20, after: descLabel)
    }
    
    private func setupViewProperties() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
        
        titleLabel.font = .font26PBold
        descLabel.font = .font16P
        
        titleLabel.textColor = .heroBlack100s
        descLabel.textColor = .heroGray600s
        
        titleLabel.textAlignment = .center
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        
        topButton.alertButtonType = .okay
        bottomButton.alertButtonType = .cancel

        alertContentView.backgroundColor = .heroWhite100s
        alertContentView.layer.shadowOpacity = 0.3
        alertContentView.layer.cornerRadius = 24
        alertContentView.layer.shadowRadius = 24
        alertContentView.layer.shadowColor = UIColor.heroBlack100s.cgColor
    }
    
    public func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    public func setDescription(description: String) {
        self.descLabel.text = description
    }
}
