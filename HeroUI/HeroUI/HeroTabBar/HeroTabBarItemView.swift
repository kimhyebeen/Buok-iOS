//
//  HeroTabBarItemView.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import HeroCommon
import UIKit

public protocol HeroTabBarItemViewDelegate: class {
    func tabBarItemView(clicked index: Int)
}

public class HeroTabBarItemView: UIView {
    private let containerButton: UIButton = UIButton()
    private let itemStackView: UIStackView = UIStackView()
    private let itemImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    public weak var delegate: HeroTabBarItemViewDelegate?
    public var heroItemIndex: Int?
    public var heroItem: HeroTabBarItem? {
        didSet {
            titleLabel.text = heroItem?.title
            itemImageView.image = heroItem?.image?.withRenderingMode(.alwaysTemplate)
            
            updateViewLayout()
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            updateViewLayout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainLayout() {
        layer.cornerRadius = 8
        
        addSubview(itemStackView)
        itemStackView.axis = .vertical
        itemStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.greaterThanOrEqualToSuperview().offset(4)
            make.trailing.lessThanOrEqualToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(itemStackView.snp.height)
        }
        
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(titleLabel)
        
        addSubview(containerButton)
        containerButton.addTarget(self, action: #selector(onClickItem(_:)), for: .touchUpInside)
        containerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.greaterThanOrEqualToSuperview().offset(4)
            make.trailing.lessThanOrEqualToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(containerButton.snp.height)
        }
        
        titleLabel.font = .font10P
        titleLabel.textAlignment = .center
        itemImageView.contentMode = .center
        bringSubviewToFront(containerButton)
        
        updateViewLayout()
    }
    
    private func updateViewLayout() {
        let isEmphasis = heroItem?.isEmphasis ?? false
        backgroundColor = isEmphasis ? .heroBlue100s : .clear
        titleLabel.textColor = isEmphasis ? .heroWhite100s : (isSelected ? .heroBlue100s : .heroGray600s)
        itemImageView.tintColor = isEmphasis ? .heroWhite100s : (isSelected ? .heroBlue100s : .heroGray600s)
    }
    
    @objc
    private func onClickItem(_ sender: UIButton) {
        if let index = heroItemIndex {
            delegate?.tabBarItemView(clicked: index)
        }
    }
}
