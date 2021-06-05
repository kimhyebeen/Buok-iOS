//
//  HeroAlertController.swift
//  HeroUI
//
//  Copyright © 2021 Buok. All rights reserved.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public enum HeroAlertButtonType: Int {
    case negative = 0
    case positive = 1
}

public protocol HeroAlertViewDelegate: AnyObject {
    func selectViewCloseClicked(viewController: HeroAlertViewController)
    
    func selectViewItemSelected(viewController: HeroAlertViewController, selected type: HeroAlertButtonType)
}

public class HeroAlertViewController: UIViewController {
    private let overLayWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private let contentView: UIView = UIView()
    private let selectContentView: UIView = UIView()
    
    private let titleView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton()
    private let separator: UIView = UIView()
    
    private let contentStackView: UIStackView = UIStackView()
    private let contentLabel: UILabel = UILabel()
    private let subContentLabel: UILabel = UILabel()
    
    private let buttonStackView: UIStackView = UIStackView()
    private let negativeButton: UIButton = UIButton()
    private let positiveButton: UIButton = UIButton()
    
    public weak var delegate: HeroAlertViewDelegate?
    
    public var titleContent: String = "" {
        didSet {
            titleLabel.text = titleContent
        }
    }
    
    public var descContent: String = "" {
        didSet {
            contentLabel.text = descContent
        }
    }
    
    public var subDescContent: String = "" {
        didSet {
            subContentLabel.text = subDescContent
        }
    }
    
    public var negativeButtonTitle: String = "" {
        didSet {
            negativeButton.setTitle(negativeButtonTitle, for: .normal)
        }
    }
    
    public var positiveButtonTitle: String = "" {
        didSet {
            positiveButton.setTitle(positiveButtonTitle, for: .normal)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        overLayWindow.backgroundColor = .clear
        overLayWindow.windowLevel = .normal + 25
        overLayWindow.makeKeyAndVisible()
        overLayWindow.isHidden = false
        
        overLayWindow.addSubview(contentView)
        contentView.addSubview(selectContentView)
        
        contentView.backgroundColor = .heroGray333333700
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        selectContentView.layer.cornerRadius = 8
        selectContentView.layer.masksToBounds = true
        selectContentView.backgroundColor = .heroWhite100s
        
        selectContentView.addSubview(titleView)
        selectContentView.addSubview(contentStackView)
        selectContentView.addSubview(buttonStackView)
        
        contentStackView.addArrangedSubview(contentLabel)
        contentStackView.addArrangedSubview(subContentLabel)
        
        buttonStackView.addArrangedSubview(negativeButton)
        buttonStackView.addArrangedSubview(positiveButton)
        
        titleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(closeButton)
        titleView.addSubview(separator)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1.5)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(closeButton.snp.height)
        }
        
        titleLabel.font = .font17PMedium
        titleLabel.textColor = .heroGray5B
        closeButton.setImage(UIImage(heroSharedNamed: "ic_x_bold"), for: .normal)
        closeButton.addTarget(self, action: #selector(onClickClose(_:)), for: .touchUpInside)
        separator.backgroundColor = .heroGrayF1F1F1
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 15
        
        contentLabel.textAlignment = .center
        subContentLabel.textAlignment = .center
        
        contentLabel.textColor = .heroGray5B
        contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        subContentLabel.numberOfLines = 0
        subContentLabel.textColor = .heroGray5B
        subContentLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
//        negativeButton.snp.makeConstraints { make in
//            make.width.equalTo(selectContentView.bounds.width - 32 - 15)
//        }
        
        negativeButton.backgroundColor = .heroGrayE7E1DC
        negativeButton.setTitleColor(.heroGray82, for: .normal)
        
        positiveButton.backgroundColor = .heroPrimaryNavyLight
        positiveButton.setTitleColor(.heroWhite100s, for: .normal)
        
        [negativeButton, positiveButton].forEach {
            $0.layer.cornerRadius = 6
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        negativeButton.addTarget(self, action: #selector(onClickNegative(_:)), for: .touchUpInside)
        positiveButton.addTarget(self, action: #selector(onClickPositive(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onClickClose(_ sender: UIButton) {
        delegate?.selectViewCloseClicked(viewController: self)
    }
    
    @objc
    private func onClickNegative(_ sender: UIButton) {
        delegate?.selectViewItemSelected(viewController: self, selected: .negative)
    }
    
    @objc
    private func onClickPositive(_ sender: UIButton) {
        delegate?.selectViewItemSelected(viewController: self, selected: .positive)
    }
}
