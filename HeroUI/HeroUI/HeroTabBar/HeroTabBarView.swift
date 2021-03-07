//
//  HeroTabBarView.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public protocol HeroTabBarViewDelegate: class {
    func tabBarItem(at index: Int)
}

public class HeroTabBarView: UIView {
    private var tabStackView: UIStackView = UIStackView()
    private var itemViewList: [HeroTabBarItemView] = [HeroTabBarItemView]()
    
    public var itemList: [HeroTabBarItem] = [HeroTabBarItem]() {
        didSet {
            for view in tabStackView.subviews {
                view.removeFromSuperview()
            }
            
            itemViewList.removeAll()
            for (index, item) in itemList.enumerated() {
                let itemView = HeroTabBarItemView()
                itemView.heroItem = item
                itemView.heroItemIndex = index
                itemView.isSelected = false
                itemView.delegate = self
                
                itemViewList.append(itemView)
            }
            
            for view in itemViewList {
                tabStackView.addArrangedSubview(view)
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
        
        tabStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(internalSpacing)
            make.leading.equalToSuperview().offset(internalSpacing)
            make.trailing.equalToSuperview().offset(-internalSpacing)
            make.bottom.equalToSuperview().offset(-internalSpacing)
        }
        
        let stackViewWidth = (UIScreen.main.bounds.width - 32) - (internalSpacing * 2)
        let stackViewSpacing = (stackViewWidth - (62 * 4)) / 3
        
        tabStackView.axis = .horizontal
        tabStackView.spacing = stackViewSpacing
        tabStackView.distribution = .equalSpacing
        updateViewLayout()
    }
    
    private func updateViewLayout() {
        layer.shadowColor = UIColor.heroBlack100s.cgColor
        layer.shadowRadius = borderRadius
        layer.shadowOpacity = isSpread ? 0 : 0.3
        layer.cornerRadius = borderRadius
    }
    
    public func setTabBarItemSelected(index: Int, isSelected: Bool) {
        for (idx, itemView) in tabStackView.arrangedSubviews.enumerated() {
            if let tabItemView = itemView as? HeroTabBarItemView {
                tabItemView.isSelected = (idx == index) && isSelected
            }
        }
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
