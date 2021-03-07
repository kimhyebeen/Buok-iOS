//
//  HeroTabBarView.swift
//  HeroUI
//
//  Created by denny on 2021/03/07.
//

import Foundation
import SnapKit
import UIKit

public protocol HeroTabBarViewDelegate: class {
    func tabBarItem(at index: Int)
}

public class HeroTabBarView: UIView {
    private var tabStackView: UIStackView = UIStackView()
    
    public var itemViewList: [HeroTabBarItem] = [HeroTabBarItem]() {
        didSet {
            for view in tabStackView.subviews {
                view.removeFromSuperview()
            }
            
            for (index, item) in itemViewList.enumerated() {
                let itemView = HeroTabBarItemView()
                itemView.heroItem = item
                itemView.heroItemIndex = index
                itemView.delegate = self
                tabStackView.addArrangedSubview(itemView)
            }
        }
    }
    
    public weak var delegate: HeroTabBarViewDelegate?
    
    private var internalSpacing: CGFloat = 8

    public var borderRadius: CGFloat = 12 {
        didSet {
            updateViewLayout()
        }
    }
    
    public var isSpread: Bool = false {
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
        backgroundColor = .heroWhite100s
        addSubview(tabStackView)
        tabStackView.axis = .horizontal
        tabStackView.spacing = 20
        tabStackView.distribution = .equalSpacing
        
        tabStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(internalSpacing)
            make.leading.equalToSuperview().offset(internalSpacing)
            make.trailing.equalToSuperview().offset(-internalSpacing)
            make.bottom.equalToSuperview().offset(-internalSpacing)
        }
        
        updateViewLayout()
    }
    
    private func updateViewLayout() {
        layer.shadowColor = UIColor.heroBlack100s.cgColor
        layer.shadowRadius = borderRadius
        layer.shadowOpacity = isSpread ? 0 : 0.3
        layer.cornerRadius = borderRadius
    }
}

extension HeroTabBarView: HeroTabBarItemViewDelegate {
    public func tabBarItemView(clicked index: Int) {
        if index == 3 {
            isSpread = true
            delegate?.tabBarItem(at: index)
        } else {
            isSpread = false
            delegate?.tabBarItem(at: index)
        }
    }
}
