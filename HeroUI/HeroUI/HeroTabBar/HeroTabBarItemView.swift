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
            titleLabel.isHidden = true
            itemImageView.isHidden = true
            
            if let title = heroItem?.title {
                titleLabel.text = title
                titleLabel.isHidden = false
            }
            
            if let image = heroItem?.image {
                itemImageView.image = image.withRenderingMode(.alwaysTemplate)
                itemImageView.isHidden = false
            }
            
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
            make.edges.equalToSuperview()
        }
        
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(titleLabel)
        
        addSubview(containerButton)
        containerButton.addTarget(self, action: #selector(onClickItem(_:)), for: .touchUpInside)
        containerButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.font = .font10P
        titleLabel.textAlignment = .center
        itemImageView.contentMode = .center
        itemImageView.tintColor = .heroGraySample300s
        bringSubviewToFront(containerButton)
        
        updateViewLayout()
    }
    
    private func updateViewLayout() {
        backgroundColor = .clear
        titleLabel.textColor = (isSelected ? .heroGray600s : .heroGraySample300s)
        itemImageView.tintColor = (isSelected ? .heroGray600s : .heroGraySample300s)
    }
    
    @objc
    private func onClickItem(_ sender: UIButton) {
        if let index = heroItemIndex {
            delegate?.tabBarItemView(clicked: index)
        }
    }
}
